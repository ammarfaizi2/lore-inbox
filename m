Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbSLDSeD>; Wed, 4 Dec 2002 13:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267015AbSLDSeD>; Wed, 4 Dec 2002 13:34:03 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:28901 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267013AbSLDSeB>;
	Wed, 4 Dec 2002 13:34:01 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Antonino Daplas <adaplas@pol.net>
Date: Wed, 4 Dec 2002 19:41:09 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH 1/3: FBDEV: VGA State Save/Restore module
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
X-mailer: Pegasus Mail v3.50
Message-ID: <962842B4859@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Dec 02 at 22:26, Antonino Daplas wrote:
> +static void vga_cleanup(struct fb_vgastate *state)
> +{
> +   if (state->fbbase)
> +       iounmap(state->fbbase);
> +}

Nobody is setting state->fbbase to NULL, so 
"save_vga(SAVE_FONT); restore_vga(); save_vga(0); restore_vga();"
will badly die. I think that you should change save prototype to
int fb_save_vga(int whattosave, struct fb_vgastate* state);, and at
the beginning of save you should do "memset(state, 0, sizeof(*state));"

And fbbase should not be in state variable, as this value is valid
only during duration of save or restore, not outside of them. Pass it
to function which needs it as an explicit argument.

It looks easier to me to make fb_vgastate larger structure with
crt/seq/cmap fields embeded, instead of kmallocing these portions.
Or at least allocate them together depending on 'whattosave' flag,
doing four kmalloc() to allocate about 64 bytes is waste of resources.

And do not use kmalloc() for > 4KB regions, use vmalloc (in
fonts save).

> +       state->attr = kmalloc(state->num_attr, GFP_KERNEL);
> +       state->crtc = kmalloc(state->num_crtc, GFP_KERNEL);
> +       state->gfx = kmalloc(state->num_gfx, GFP_KERNEL);
> +       state->seq = kmalloc(state->num_seq, GFP_KERNEL);
...
> +       state->vga_font0 = kmalloc(8192 * 8, GFP_KERNEL);
...
> +       state->vga_font1 = kmalloc(8192 * 8, GFP_KERNEL);
...
> +       state->vga_text = kmalloc(8192 * 4, GFP_KERNEL);

And if my VGA documentation is correct, you are saving random
data into vga_text: first 8192 chars interleaved with
8192 bytes of garbage, plus attributes from chars 8192-16383 interleaved
with 8192 bytes of garbage. 

When you program hardware to get access to planes (vga 16 color 
graphics mode), every second byte from plane 0 contains character, 
and every second byte from plane 1 contains character attribute 
(it is that way because of bit A0 selects plane, while A15-A1.0 
selects memory address, so odd in memory addresses are unreachable 
in vga text mode).

And if you are using standard hardware, then font data live only in
plane 2, plane 3 is unused on VGA hardware in text mode. I think that
you should either save whole 256KB of memory, without deeper understanding,
or you should just save FONT 0 (first 32*256 bytes from plane 2) if you
want to save memory and you know that console was driven by vgacon in
text mode.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
