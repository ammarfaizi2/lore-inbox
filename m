Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTLYUeG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 15:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTLYUeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 15:34:06 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:30223 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263800AbTLYUeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 15:34:02 -0500
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andrea Barisani <lcars@infis.univ.trieste.it>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       alsa-devel@alsa-project.org
Subject: Re: kernel 2.6.0, wrong Kconfig directives
References: <20031222235622.GA17030@sole.infis.univ.trieste.it>
	<87smj8bt6y.fsf@devron.myhome.or.jp>
	<20031225195115.GQ31789@actcom.co.il>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 26 Dec 2003 05:33:06 +0900
In-Reply-To: <20031225195115.GQ31789@actcom.co.il>
Message-ID: <87isk4bptp.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> writes:

> On Fri, Dec 26, 2003 at 04:20:21AM +0900, OGAWA Hirofumi wrote:
> > 
> > > - SOUND_GAMEPORT option is always turned on
> > > 
> > > ./drivers/input/gameport/Kconfig
> > > 
> > > 22: config SOUND_GAMEPORT
> > > 23:         tristate
> > > 24:         default y if GAMEPORT!=m
> > > 25:         default m if GAMEPORT=m
> > > 
> > > line 24 is definetly wrong, option is enabled if GAMEPORT=n.
> > 
> > This patch uses "select" for the dependency of GAMEPORT.
> 
> This is wrong. It forces the joystick (GAMEPORT) in even when it's not
> needed, whereas SOUND_GAMEPORT handles all cases fine. That way lies
> kernel bloat. Please apply this documentation patch instead: 
> 
> Index: drivers/input/gameport/Kconfig
> ===================================================================
> RCS file: /home/muli/kernel/cvsroot/linux-2.5/drivers/input/gameport/Kconfig,v
> retrieving revision 1.4
> diff -u -u -r1.4 Kconfig
> --- drivers/input/gameport/Kconfig	26 Sep 2003 00:23:18 -0000	1.4
> +++ drivers/input/gameport/Kconfig	25 Dec 2003 19:48:49 -0000
> @@ -19,6 +19,17 @@
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called gameport.
>  
> +
> +# Yes, this looks a bit odd. Yes, it ends up being turned on in lots
> +# of cases. Please don't touch it. It is here to handle the case where
> +# a sound driver can be either a module or compiled in if GAMEPORT is
> +# not selected, but must be a module if the joystick is selected as a 
> +# module. The sound driver calls GAMEPORT functions. If GAMEPORT is
> +# not selected, stubs are provided. If GAMEPORT is built in,
> +# everything is fine. If GAMEPORT is a module, however, it would need
> +# to be loaded for the sound driver to be able to link
> +# properly. Therefore, the sound driver must be a module as well in
> +# that case (and the GAMEPORT module must be loaded first). 
>  config SOUND_GAMEPORT
>  	tristate
>  	default y if GAMEPORT!=m

I see. So why did we need the SOUND_GAMEPORT?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
