Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbVITMee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbVITMee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbVITMee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:34:34 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:65438 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S965000AbVITMed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:34:33 -0400
In-Reply-To: <20050920051729.GF7992@ftp.linux.org.uk>
References: <1127181641.16372.10.camel@vertex> <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org> <1127188015.17794.6.camel@vertex> <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org> <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex> <20050920044623.GD7992@ftp.linux.org.uk> <1127191992.19093.3.camel@vertex> <20050920045835.GE7992@ftp.linux.org.uk> <1127192784.19093.7.camel@vertex> <20050920051729.GF7992@ftp.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Content-Transfer-Encoding: 7bit
From: John McCutchan <ttb@tentacle.dhs.org>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Date: Tue, 20 Sep 2005 08:34:20 -0400
To: Al Viro <viro@ftp.linux.org.uk>
X-Mailer: Apple Mail (2.734)
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.9.20.8
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Sep-05, at 1:17 AM, Al Viro wrote:

> On Tue, Sep 20, 2005 at 01:06:23AM -0400, John McCutchan wrote:
>
>> On Tue, 2005-09-20 at 05:58 +0100, Al Viro wrote:
>>
>>> On Tue, Sep 20, 2005 at 12:53:12AM -0400, John McCutchan wrote:
>>>
>>>> DELETE_SELF WD=X
>>>>
>>>> The path you requested a watch on (inotify_add_watch(path,mask)  
>>>> returned
>>>> X) has been deleted.
>>>>
>>>
>>> Then why the devil do we have IN_DELETE and IN_DELETE_SELF generated
>>> in different places?  The only difference is in who receives the
>>> event - you send IN_DELETE to watchers on parent and IN_DELETE_SELF
>>> on watchers on victim.  Event itself is the same, judging by your
>>> description...
>>>
>>
>> No, because in the case of IN_DELETE, the path represented by the WD
>> hasn't been deleted, it is "PATH(WD)/event->name" that has been.
>>
>
> That's OK - same thing described for different recepients, thus two
> events with different contents and type being sent.
>
>
>> Also,
>> IN_DELETE_SELF marks the death of the WD, no further events will  
>> be sent
>> with the same WD [Except for the IN_IGNORE].
>>
>
> Uh-oh...  Now, _that_ is rather interesting - you are giving self- 
> contradictory
> descriptions of the semantics.
>

Where is the contradiction?

> fd = open("foo", 0);
> unlink("foo");
> sleep for a day
> fchmod(fd, 0400);
> sleep for a day
> close(fd);
>
> Which events do we have here?  Removal of path happens at unlink();  
> change
> of attributes - a day later.
>

[I'm assuming that fchmod continues to work even if the path has been  
deleted.]

With Linus's latest patch:

IN_ATTRIB
IN_DELETE_SELF
IN_IGNORE

If we were able to get inoderemove called when the path removal happens,

IN_DELETE_SELF
IN_IGNORE

At this point, inotify would stop monitoring the inode, and we would  
never see the fchmod.

John McCutchan
ttb@tentacle.dhs.org



