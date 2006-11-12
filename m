Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753250AbWKLVoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbWKLVoq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 16:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbWKLVoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 16:44:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:63437 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1753250AbWKLVop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 16:44:45 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [patch] floppy: suspend/resume fix
To: Ingo Molnar <mingo@elte.hu>, Mikael Pettersson <mikpe@it.uu.se>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 12 Nov 2006 22:44:28 +0100
References: <7grMO-2YO-55@gated-at.bofh.it> <7gs69-46A-37@gated-at.bofh.it> <7gtvd-7xg-23@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GjN7s-00024n-VV@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert%gmx.de-bounce@7eggert.dyndns.org
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> At a guess, what's probably happening is that the floppy drive, when
> powered on after resume, reports "disk changed" because it doesn't
> know any better.
> 
> We interpret "disk changed" to mean the disk has been removed and
> possibly changed (which _is_ correct) and thereby abort any further
> IO (irrespective of resume.)
> 
> Now, consider the following two scenarios:
> 
> 1. You suspend and then resume, leaving the disk in the floppy drive.
> 
> 2. You suspend, remove the floppy disk, insert a totally different disk
>    in the same drive, and then resume.
> 
> What should you do?  (Hint: without reading the disk and comparing it
> with what you have cached you don't know if the disk has been changed
> or not.)
> 
> If you argue that in case (1) you should continue to allow IO, then
> you potentially end up scribbling over a disk when someone does (2).
> 
> So I'd argue that the behaviour being seen by Mikael is the _safest_
> behaviour, and the most correct behaviour given the limitations of
> the hardware.

- If a user suspends with a floppy in the drive, it will mostly be an error,
  and he'll unsuspend in order to correct it.
- If it is no error, putting a different/modified floppy into the drive
  before resume is unlikely
- Even if somebody does this, you can mostly detect the different disk
  by comparing the first sector or just the FAT "serial number".

Therefore you can implement a relatively safe resume that will mostly DTRT
but destroy data in some unlikely cases, while doing the "safe thing" would
mostly cause a harmless (unless not noticed) kind of data loss and sometimes
safe you from real data loss.

I think you should let the user choose which foot to shoot.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
