Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUKISyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUKISyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbUKISyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:54:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:11225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261610AbUKISyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:54:04 -0500
Date: Tue, 9 Nov 2004 10:53:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Kujau <evil@g-house.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@gmail.com>, Greg KH <greg@kroah.com>,
       Matt_Domsch@dell.com
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
In-Reply-To: <20041109164238.M12639@g-house.de>
Message-ID: <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org>
References: <4180F026.9090302@g-house.de>  <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>
  <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de> 
 <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>  <418F6E33.8080808@g-house.de>
  <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>  <418FDE1F.7060804@g-house.de>
 <419005F2.8080800@g-house.de>  <41901DF0.8040302@g-house.de>
 <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de>
 <20041109164238.M12639@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Nov 2004, Christian Kujau wrote:
> 
> at least i finally found the "bad" .config option: it's CONFIG_EDD.
> when i disable this option (and only this options. i can use the same
> .config as usual only disbaling this very option. diff is my witness.)
> i can boot a current (!) 2.6.10-rc1-bk and a working snd-ens1371!

Very strange. There's not a lot of stuff that affects EDD directly that I 
can see, but there is:

	ChangeSet@1.2000.5.108, 2004-10-20 08:36:22-07:00, Matt_Domsch@dell.com
	  [PATCH] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
	  
	  Some controller BIOSes have problems with the legacy int13 fn02 READ
	  SECTORS command.  int13 fn42 EXTENDED READ is used in preference by most
	  boot loaders today, so lets use that.  If EXTENDED READ fails or isn't
	  supported, fall back to READ SECTORS.
	  
	  This hopefully resolves the three reports of BIOSes which would either
	  long-pause (30+ seconds) or hang completely on the legacy READ SECTORS
	  command.
	  
	  This also adds CONFIG_EDD_SKIP_MBR to eliminate reading the MBR on each
	  BIOS-presented disk, in case there are further problems in this area.
	  
	  Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
	  Signed-off-by: Andrew Morton <akpm@osdl.org>
	  Signed-off-by: Linus Torvalds <torvalds@osdl.org>

which might fit the bill.

However, even that would just change the EDD _data_, it doesn't change the 
code that actually runs in the kernel. And I _really_ don't see what EDD 
has got to do with anything.

I wonder if the EDD stuff corrupts the sysfs tree or something, and you're
just seeing some strange kobject interference. Greg, you'd likely still be
on the line for that one.

Christian, finding which change triggers this would be very good indeed. I 
think the merge with greg is still a good place to start, although even 
just doing the snapshot trees (from _before_ -rc1: ie the patches in 
/pub/linux/kernel/v2.6/snapshots/old: patch-2.6.9-bk*.gz) is actually also 
a good way to narrow things down.

		Linus
