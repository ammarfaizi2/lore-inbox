Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUHRWJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUHRWJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 18:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUHRWJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 18:09:19 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:46983 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267904AbUHRWJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 18:09:17 -0400
Message-ID: <41247C40.5DB76262@us.ibm.com>
Date: Thu, 19 Aug 2004 05:09:04 -0500
From: "Steve French (IBM LTC)" <smfltc@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-cifs-client@lists.samba.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: re: Problem with CIFS
References: <20040818120033.9DD101638C1@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was trying to use CIFS, but it failed to mount my samba shares
> whereas mounting a share of a Win2K PC worked.   <snip>
> In fs/cifs/cifssmb.c around line 238 the cifs modul expects a 16 Byte
> GUID, where samba only send 14 bytes consisting of some random
> numbers followed by my workgroupname: WG.
> So I to set my workgroupname to something longer with enabled me to
> mount my share.

This is caused by an interesting bug in Samba, but one I should be able to
workaround.  Basically Samba is setting a flag in the negotiate response saying
    "I support extended security"
which indicates that this frame should be decoded as if it contained an SPNEGO blob
(ala RFC 2478) and a conflicting capability in the same frame which indicates
    "I am not capable of extended security"
The Samba server sets this SMB_FLAGS2_EXTENDED_SECURITY in the response even though
the client said - no extended security (Windows gets this right).   Presumably all
other smb/cifs clients either 1) negotiate extended security (this is turned off by
default in the cifs vfs ie /proc/fs/cifs/ExtendedSecurity is zero)  or 2) don't
check or don't care what is in the bcc area of the negprot response (which is the
case for earlier clients)

> but I think it should be possible to mount shares in workgroups which
> names are shorter the 4 Bytes.
Yes you are correct - there is no minimum domain length, although there is a minimal
bcc length for true NTLMSSP and SPNEGO negotiate responses which I will now be
forced to detect differently on the client.   As you noticed it worked for longer
domain names, because the bcc was larger and spnego decoding was harmless for longer
domain names.

I will fix this today, probably by adding a check in fs/cifs/cifssmb.c (in
CIFSSMBNegotiate) in parsing the negotiate response from something like from:

 if (pSMBr->hdr.Flags2 & SMBFLG2_EXT_SEC)

to

if ((pSMBr->hdr.Flags2 & SMBFLG2_EXT_SEC) &&
   (server->capabilities & CAP_EXTENDED_SECURITY))

The Samba fix is pretty easy as well (it only hits source/smbd/negprot.c -
reply_negprot function), I will bounce the fix off jra before updating the Samba 3
source.

