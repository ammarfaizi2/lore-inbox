Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWGDOig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWGDOig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWGDOig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 10:38:36 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:42884 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932185AbWGDOif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 10:38:35 -0400
Date: Tue, 4 Jul 2006 16:37:58 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Diego Calleja <diegocg@gmail.com>, Valdis.Kletnieks@vt.edu
cc: Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel recycler [was: ext4 features]
In-Reply-To: <Pine.LNX.4.61.0607032354170.31747@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0607041636540.4190@yvahk01.tjqt.qr>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
 <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
 <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org>
            <44A9904F.7060207@wolfmountaingroup.com>
 <200607032146.k63LkFNF027323@turing-police.cc.vt.edu>
 <Pine.LNX.4.61.0607032354170.31747@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm this one did not appear on LKML so I resend it.

On Jul 4 2006 00:01, Jan Engelhardt wrote:

>Date: Tue, 4 Jul 2006 00:01:56 +0200 (MEST)
>From: Jan Engelhardt <jengelh@linux01.gwdg.de>
>To: Jeff V. Merkey <jmerkey@wolfmountaingroup.com>,
>    Diego Calleja <diegocg@gmail.com>, Valdis.Kletnieks@vt.edu
>Cc: Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
>    Helge Hafting <helgehaf@aitel.hist.no>,
>    Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
>    Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
>Subject: Kernel recycler [was: ext4 features]
>
>>>
>> Add a salvagable file system to ext4, i.e. when a file is deleted, you just
>> rename it and move it to a directory called DELETED.SAV and recycle the files
>> as people allocate new ones.  Easy to do (internal "mv" of file to another
>> directory) and modification of the allocation bitmaps.  Very simple and will
>> pay off big.  If you need help designing it, just ask me.
>>
>
>Hey, can you help? I had this idea of a kernel-level 'recyler' (FS-independent)
>a while ago (patch file is March 26 according to my `ls -l`) [1], but I have
>suspended it for the moment because it is a tedius task for API-newcomers 
>like me. (I currently have to look at a lot of other kernel code to figure 
>out what the proper way of doing things is.)
>
>And it comes with some problems:
>
>- recycled files ("deleted" and moved) shall not count into the user's quota
>
>- rm -Rf bigfatdirectory will keep a lot of files around, therefore we would
>  need an extra kthread that kills all files in DELETED.SAV after a tunable
>  period.
>
>[1] http://jengelh.hopto.org/recycler.diff
>
>
>>From: Diego Calleja <diegocg@gmail.com>
>>
>>Easily doable in userspace, why bother with kernel programming
>
>Because not every application will use KDE's trash feature, or will use
>/bin/my_rm or or or. I certainly do not have the time to patch any program out
>there to use /bin/my_rm or my_unlink() function. What about statically compiled
>programs? They call the syscall directly, so there is no way (without
>recompiling - if possible at all) to catch it within userspace.
>
>And what about if knfsd is about to delete a file? Let's assume we cannot trust
>the client, so the only choice here is to have a kernel recycler.
>
>>Much better done in userspace - the kernel can't get this right without
>>some user hinting.  For starters, it creates a big security hole in all
>>the code that does an open()/unlink().
>>
>>Also, how do you handle the corner cases?  The fact you're adding to the
>>pathname of the file means you might push some long names over the MAXPATHLEN
>>value, and you have to worry about name collisions in the directory, and
>>so on.  There's also more subtle leakage issues, such as properly handling
>>the permissions on the files on a multi-user system so users can't rummage
>>each other's trash....
>
>I am aware of these problems, but at least for fun & profit, I would like to
>complete the kernel-level recycler.
>
>
>Jan Engelhardt
>-- 
>
