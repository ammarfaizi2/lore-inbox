Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269423AbTGOSV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269428AbTGOSV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:21:57 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:38665 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269423AbTGOSVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:21:36 -0400
Date: Tue, 15 Jul 2003 19:36:24 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dave Jones <davej@codemonkey.org.uk>, <dank@reflexsecurity.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
In-Reply-To: <1058291363.3845.53.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307151854100.7746-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >    Also doing this kind of thing only covers up broken framebuffer 
> > drivers. Unfortunetly its going to take me months to cleanup and make the 
> > fbdev drivers behave right. 
> 
> We don't have months. Should we be talking about reverting to the rather
> solid 2.4 framebuffer side for 2.6 in this case ?

   Its not that the 2.5.X framebuffer layer is not solid. Except for the 
software cursor it behaves right. The issue I have is the quality of the 
framebuffer drivers. Lets take a example. In the new api we have two new
functions called check_var and set_par. Check_var's job is to test a 
passed in mode to see if the hardware can support it. It is not to alter 
or change any hardware states. The second function set_par does change the
hardware state. Lets look at the Mach64 driver. Mind you it does work and 
functions. We have 

static int atyfb_check_var(struct fb_var_screeninfo *var,
                           struct fb_info *info)
{
        struct atyfb_par *par = (struct atyfb_par *) info->par;
        struct crtc crtc;
        union aty_pll pll;
        int err;
                                                                                  
        if ((err = aty_var_to_crtc(info, var, &crtc)) ||
            (err = par->pll_ops->var_to_pll(info, var->pixclock,
                                        var->bits_per_pixel, &pll)))
                return err;
                                                                                  
#if 0   /* fbmon is not done. uncomment for 2.5.x -brad */
        if (!fbmon_valid_timings(var->pixclock, htotal, vtotal, info))
                return -EINVAL;
#endif
        aty_crtc_to_var(&crtc, var);
        var->pixclock = par->pll_ops->pll_to_var(info, &pll);
	return 0;
}

We can see here that we first pass var into aty_var_to_crtc to generate a
crtc struct. Then at the end we do the reverse and use that crtc to create
a var. This is horribly done. Now lets look at what is in set_par.

        if ((err = aty_var_to_crtc(info, var, &par->crtc)) ||
            (err = par->pll_ops->var_to_pll(info, var->pixclock,
                                        var->bits_per_pixel, &par->pll)))
                return err;

Its being called twice. Once in check_var and again in set_par. Mind you 
this works but the implementation is horribly done. I see this done alot 
in various drivers. The reason it was done this way was because people 
wanted a quick port to the new api without thinking much about it. 
   
    What makes me sad is I added accel hooks to speed up the console but I 
don't see anyone using there accel engines. Everyone is just using my soft 
accel functions :-( Using the soft accel was to be the exception not the 
rule.


