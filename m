Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312783AbSCVSPT>; Fri, 22 Mar 2002 13:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312784AbSCVSPI>; Fri, 22 Mar 2002 13:15:08 -0500
Received: from ns.suse.de ([213.95.15.193]:59659 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312783AbSCVSOz>;
	Fri, 22 Mar 2002 13:14:55 -0500
Date: Fri, 22 Mar 2002 19:14:54 +0100
From: Dave Jones <davej@suse.de>
To: Jon Hourd <jonhourd@telus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 - 2.5.7  bluesmoke.c corrected MCA setup for different Pentium cores.
Message-ID: <20020322191454.O22861@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jon Hourd <jonhourd@telus.net>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.0.20020322094928.009e6ec0@pop.telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2002 at 10:05:16AM -0800, Jon Hourd wrote:
 > Hello,
 > 	Here are some patches to correct the MCA setup for different Pentium cores 
 > in bluesmoke.c.  The P6 family must not initialize MSR_IA32_MC0_CTL in 
 > software, it must be done by the bios.  The P4/Xeon cores must have this 
 > bank initialized in software.  Added check for processor type and 
 > associated init loops.  Included patches against 2.5.7 and 2.4.18.

Just a tiny nit to pick...

@@ -167,9 +169,25 @@
 	if(l&(1<<8))
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 	banks = l&0xff;
-	for(i=1;i<banks;i++)
-	{
-		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
+
+	/* Check Core version for P6 or P4/Xeon */
+
+	if(c->x86 == 6)	{
+		printk(KERN_INFO "Detected P6 Core.\n");
+		for(i=1;i<banks;i++)			/* Must start with bank 1 for P6 Cores */
+		{
+			wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
+		}
+	} else if(c->x86 == 15) {
+		printk(KERN_INFO "Detected P4/Xeon Core.\n");
+		for(i=0;i<banks;i++)			/* Must start with bank 0 for Pentium 4 and Xeon Processors */

This function can be called by non-Intel hardware. No other vendor has
a family 15 CPU, but it's one less surprise if ever someone does make
one.

Also, take a look at bluesmoke.c in 2.5.7-dj1, it's quite a bit
different from mainline (in particular the timer foo), and also
incorporates some of the bits from your patch already.

Other than that, looks fine to me.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
