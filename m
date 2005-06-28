Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVF1Hqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVF1Hqc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVF1G3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:29:47 -0400
Received: from fmr18.intel.com ([134.134.136.17]:53944 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261760AbVF1GPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:15:44 -0400
Subject: Re: [PATCH]MTRR suspend/resume cleanup
From: Shaohua Li <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk,
       ncunningham@cyclades.com, ak@muc.de, pavel@ucw.cz
In-Reply-To: <20050627222444.370457d4.akpm@osdl.org>
References: <1119936124.3158.9.camel@linux-hp.sh.intel.com>
	 <20050627222444.370457d4.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 14:24:36 +0800
Message-Id: <1119939877.3832.1.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 13:24 +0800, Andrew Morton wrote:
> > @@ -332,6 +332,7 @@ int mtrr_add_page(unsigned long base, un
> > 
> >       error = -EINVAL;
> > 
> > +     lock_cpu_hotplug();
> >       /*  Search for existing MTRR  */
> >       down(&main_lock);
> >       for (i = 0; i < num_var_ranges; ++i) {
>        
> Is this new locking?  If so, please describe it.
> > +
> > +static int __init mtrr_init_finialize(void)
> > +{
> > +     if (!mtrr_if)
> > +             return 0;
> > +     if (use_intel())
> > +             mtrr_state_warn();
> > +     else
> > +     /* The CPUs haven't MTRR and seemes not support SMP. They have
> specific
> > +      * drivers, we use a tricky method to support suspend/resume
> for them
> > +      * TBD: is there any system with such CPU which supports
> suspend/resume?
> > +      * if no, we should remove the code.
> > +      */
> > +             sysdev_driver_register(&cpu_sysdev_class,
> > +                     &mtrr_sysdev_driver);
> > +     return 0;
> > +}
> 
> That's pretty hard to read.  Braces will improve it:
> 
>         if (use_intel()) {
>                 mtrr_state_warn();
>         } else {
>                 /*
>                  * The CPUs haven't MTRR and seemes not support SMP.
> They have
>                  * specific drivers, we use a tricky method to support
>                  * suspend/resume for them.
>                  * TBD: is there any system with such CPU which
> supports
>                  * suspend/resume?  If no, we should remove the code.
>                  */
>                 sysdev_driver_register(&cpu_sysdev_class,
>                         &mtrr_sysdev_driver);
>         }
> 
> > +#ifdef CONFIG_MTRR
> > +extern int mtrr_ap_init(void);
> > +extern int mtrr_bp_init(void);
> > +#else
> > +#define mtrr_ap_init()
> > +#define mtrr_bp_init()
> > +#endif
> 
> If this works, it means we're always ignoring the return values and
> these
> things should return void.
> 
> Otherwise the !CONFIG_MTRR stubs should be returning an integer.  So
> we
> need either:
> 
> #ifdef CONFIG_MTRR
> extern void mtrr_ap_init(void);
> extern void mtrr_bp_init(void);
> #else
> #define mtrr_ap_init()  do {} while (0)         (or static inlines)
> #define mtrr_bp_init()  do {} while (0)
> #endif
> 
> or
> 
> #ifdef CONFIG_MTRR
> extern int mtrr_ap_init(void);
> extern int mtrr_bp_init(void);
> #else
> static inline int mtrr_ap_init(void) { return 0; }
> static inline int mtrr_bp_init(void) { return 0; }
> #endif
> > +#ifdef CONFIG_MTRR
> > +extern int mtrr_ap_init(void);
> > +extern int mtrr_bp_init(void);
> > +#else
> > +#define mtrr_ap_init()
> > +#define mtrr_bp_init();
> > +#endif
> Ditto.
Thanks for your feedback. I will update the patch when I collect all
comments.

Thanks,
Shaohua

