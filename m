Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUFSGP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUFSGP5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 02:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUFSGP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 02:15:57 -0400
Received: from babyruth.hotpop.com ([38.113.3.61]:21713 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S264795AbUFSGPz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 02:15:55 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Jakub Bogusz <qboosh@pld-linux.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] 2.6.7 fbcon: set_con2fb on current console = crash
Date: Sat, 19 Jun 2004 14:13:44 +0800
User-Agent: KMail/1.5.4
Cc: pld-kernel@pld-linux.org
References: <20040618215047.GA4723@satan.blackhosts>
In-Reply-To: <20040618215047.GA4723@satan.blackhosts>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191413.44439.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 June 2004 05:50, Jakub Bogusz wrote:
> After upgrade from 2.6.4 to 2.6.7 I noticed that calling set_con2fb
> (through FBIOPUT_CON2FBMAP ioctl) on current console (already attached
> to fb using this ioctl) causes crash (oops and then recursive oops when
> trying to printk on console) and makes console unusable.
>
> That's because take_over_console() calls fbcon_deinit(vc_num)
> (which calls fbcon_free_font() on that console display) and then
> fbcon_init(vc_num, ...), which copies font data from current fb console.
> If current console was just deinit()ed, its fontdata is NULL - and this
> pointer is "copied" to the same place, leaving current console with
> fontdata==NULL (which leads to oops on nearest putc/putcs).
>
> Attached patch restores 2.6.4 behaviour on set_con2fb (to set font if
> it's not set already) - but it's not perfect solution as user font is
> still lost (unline on 2.4.x kernels).
> Any idea how to preserve user font on set_con2fb() called on current
> console?

Thanks.  Actually there's still a critical flaw in the set_con2fbmap code.  
For one, con2fb_map is never initialized.  It's just fortunate that this 
array happens to be  filled with zeroes so con2fb_map[n] will always return 
zero and registered_fb[0] happens to contain a valid info.  So it works, by 
accident. 

Secondly, if you load fbdev1, load fbdev2, unload fbdev1, load fbcon, the 
console will freeze. This is because fbdev1, which is originally in 
registered_fb[0], is now unloaded, and fbdev2, which is in registered_fb[1] 
is still loaded.  However, fbcon looks at registered_fb[0] during init.

Also, I really don't like the take_over_console part in set_con2fbmap.  Too 
many unknowns. 

There are still lot more problems which I won't mention. I'll try to fix some 
of them over this weekend.

Tony


