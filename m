Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSLJRDh>; Tue, 10 Dec 2002 12:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSLJRDh>; Tue, 10 Dec 2002 12:03:37 -0500
Received: from [213.171.53.133] ([213.171.53.133]:41735 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S262395AbSLJRDg>;
	Tue, 10 Dec 2002 12:03:36 -0500
Date: Tue, 10 Dec 2002 20:11:56 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <7981207400.20021210201156@wr.miee.ru>
To: Roger A Oksanen <raoksane@cs.Helsinki.FI>
CC: linux-kernel@vger.kernel.org, davej@suse.de, trivial@rustcorp.com.au
Subject: Re: Radix tree related oops in 2.5.51-mm1
In-Reply-To: <Pine.LNX.4.44.0212101809460.6514-100000@melkki.cs.Helsinki.FI>
References: <Pine.LNX.4.44.0212101809460.6514-100000@melkki.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger and all.
RAO> Oh, and just in case someone tries to compile with my config; to get the
RAO> ALSA AWE32 code to compile (in sb16.c) , I had to change the init variable c
RAO> sp as it was a duplicate of the global csp variable..
RAO> I should probably see(test) if the plain 2.5.51 has this problem also..
RAO> # CONFIG_SND_SB16 is not set
RAO> CONFIG_SND_SBAWE=y
RAO> CONFIG_SND_SB16_CSP=y
I have same problem with it. Somebody miss this fact when striped out
snd prefix in this driver. I've send patch to kernel list, but it was
skiped.
But with solving this problem you don't have CSP enabled because it's
disabled by default and you must use bootparams to enable it:
#ifdef CONFIG_SND_SB16_CSP
static int csp[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 0};
#endif

Here is my TRIVIAL patch.
--- sound/isa/sb/sb16.c.orig    Tue Dec 10 19:46:41 2002
+++ sound/isa/sb/sb16.c Tue Dec 10 19:48:27 2002
@@ -664,7 +664,7 @@
 {
        static unsigned __initdata nr_dev = 0;
        int __attribute__ ((__unused__)) pnp = INT_MAX;
-       int __attribute__ ((__unused__)) csp = INT_MAX;
+       int __attribute__ ((__unused__)) xcsp = INT_MAX;

        if (nr_dev >= SNDRV_CARDS)
                return 0;
@@ -681,7 +681,7 @@
               get_option(&str,&mic_agc[nr_dev]) == 2
 #ifdef CONFIG_SND_SB16_CSP
               &&
-              get_option(&str,&csp[nr_dev]) == 2
+              get_option(&str,&xcsp) == 2
 #endif
 #ifdef SNDRV_SBAWE_EMU8000
               &&
@@ -694,8 +694,8 @@
                isapnp[nr_dev] = pnp;
 #endif
 #ifdef CONFIG_SND_SB16_CSP
-       if (csp != INT_MAX)
-               csp[nr_dev] = csp;
+       if (xcsp != INT_MAX)
+               csp[nr_dev] = xcsp;
 #endif
        nr_dev++;
        return 1;
Best Regards.
             Ruslan. See you later...

