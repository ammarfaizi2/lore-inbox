Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUCEF3A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 00:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUCEF3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 00:29:00 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:39835 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S262224AbUCEF2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 00:28:53 -0500
Date: Thu, 4 Mar 2004 21:24:40 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: daniel@zonque.org, akpm <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.4-rc2: scripts/modpost.c
Message-Id: <20040304212440.30fc8674.randy.dunlap@verizon.net>
In-Reply-To: <20040304172923.6045760e.rddunlap@osdl.org>
References: <20040304172923.6045760e.rddunlap@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [4.5.45.142] at Thu, 4 Mar 2004 23:28:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| (This is is a repost - now with a patch for 2.6.4-rc2).
| 
| Hi,
| 
| as I found out, it's impossible to use the build-chain tool scripts/modpost
| of the 2.6 kernel series to externally build modules from a directory that
| contains the character sequence '.o'. Weird things happen if you try to do
| so.
| 
| With a directory structure like on my system here, building the current DVB
| driver in '/home/daniel/cvs.linuxtv.org/dvb-kernel/build-2.6i/' generates a 
| file called '/home/daniel/cvs.linuxtv.mod.c' since modpost cuts every 
| filename string at the first occurence of '.o', not only the 'trailing .o',
| as the comment says.

The comment and code certainly don't match, and your patch makes sense
to me.  However, I can't reproduce the problem that you describe.

I built the kernel image and modules in "www.osdl.org/264rc2/build1",
and all *.mod.c and *.ko ended up there with no problems.
Then I modified modpost.c (from 2.6.4-rc1, without your patch) to
print the "stripped" module names (without the trailing ".o")
and saw a list like this:
modpost: stripped mod.name=[fs/jfs/jfs]

so where are the parent directory names that are causing problems
for you coming from?


Andrew, I applied the patch and didn't have any problems with
'make allyesconfig' like you alluded to.


| Here's the patch for 2.6.4-rc2:
| 
| 
| --- linux-2.6.4-rc2.orig/scripts/modpost.c      2004-03-04 11:40:21.000000000 +0100
| +++ linux-2.6.4-rc2/scripts/modpost.c   2004-03-04 11:23:08.000000000 +0100
| @@ -63,16 +63,16 @@
|  new_module(char *modname)
|  {
|         struct module *mod;
| -       char *p;
| +       int len;
|  
|         mod = NOFAIL(malloc(sizeof(*mod)));
|         memset(mod, 0, sizeof(*mod));
|         mod->name = NOFAIL(strdup(modname));
|  
|         /* strip trailing .o */
| -       p = strstr(mod->name, ".o");
| -       if (p)
| -               *p = 0;
| +       len = strlen(mod->name);
| +       if (len > 2 && mod->name[len-2] == '.' && mod->name[len-1] == 'o')
| +               mod->name[len-2] = 0;
|  
|         /* add to list */
|         mod->next = modules;

--
~Randy
