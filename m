Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVCNHWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVCNHWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 02:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVCNHWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 02:22:40 -0500
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:60609 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S261210AbVCNHWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 02:22:36 -0500
Subject: Re: Fw: [CIFS] Add support for updating Windows NT times/dates
	(part 1)
From: Steve French <smfrench@austin.rr.com>
To: arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <OFC812C14F.CCC4A011-ON87256FC4.0026AB69-86256FC4.0026AF44@us.ibm.com>
References: <OFC812C14F.CCC4A011-ON87256FC4.0026AB69-86256FC4.0026AF44@us.ibm.com>
Content-Type: text/plain
Message-Id: <1110785112.3102.18.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 14 Mar 2005 01:25:12 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> > ChangeSet 1.1966.1.22, 2005/01/26 17:30:51-06:00, 
<snip>
>   
> > +/* The following three structures are needed only for
> > + setting time to NT4 and some older servers via
> > + the primitive DOS time format */
> >  typedef struct {
> > - __u16 CreationDate;
> > - __u16 CreationTime;
> > - __u16 LastAccessDate;
> > - __u16 LastAccessTime;
> > - __u16 LastWriteDate;
> > - __u16 LastWriteTime;
> > - __u32 DataSize; /* File Size (EOF) */
> > - __u32 AllocationSize;
> > - __u16 Attributes; /* verify not u32 */
> > - __u32 EASize;
> > + __u16 Day:5;
> > + __u16 Month:4;
> > + __u16 Year:7;
> > +} SMB_DATE;
> > +
> 
> if this is an on the wire format (and it looks like one) then you want
> this one packed I suspect, 

Yes - the whole cifspdu.h is pragma pack(1)  (including this struct)
On the wire fields for cifs are packed.  These two fields would not be
put on the wire directly (they would be part of a larger struct,
in particular FILE_INFO_STANDARD transact2 which follows).  Fortunately
there is an easier way to set time fields to NT4 servers (which were the
only common server which I was running into which did take the common
SetPathInfo level for setting date/time stamps).  To set the time stamps
using that legacy format ie FILE_INFO_STANDARD (which code had been
started in the currently unused CIFSSetTimesLegacy function) would
require time zone conversions as well as the conversion from
100nanosecond (CIFS time aka "DCE TIME") to the primitive 2 second (dos,
os2 time) format.  Rather than do that, a much better solution was found
using transac2 SetFileInfo (instead of SetPathInfo) - which allows using
the 100nanosecond time stamps and much simplifies the conversion.

> and also I wonder if it needs to be byte
> order specific...

Old style SMB_DATE and SMB_TIME would be little endian when on the wire,
but it is easier to convert the SMB_DATE and SMB_TIME fields while in
cpu byte order (since they are bit fields).  The SMB_DATE and SMB_TIME
fields would get cpu_to_le16 when converted in CIFSSetTimesLegacy to the
on the wire format FILE_INFO_STANDARD.  Fortunately this will probably
turn out to be moot.   Unless WindowsME or Windows9x servers force the
addition of this DOS style time stamp support, I may be able to remove
this.

