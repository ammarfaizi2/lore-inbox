Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264537AbTCYVR0>; Tue, 25 Mar 2003 16:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264539AbTCYVRZ>; Tue, 25 Mar 2003 16:17:25 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:3516 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S264537AbTCYVRY>;
	Tue, 25 Mar 2003 16:17:24 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: James Simmons <jsimmons@infradead.org>
Date: Tue, 25 Mar 2003 22:28:20 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.65 + matrox framebuffer: life is good!
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Jurriaan <thunder7@xs4all.nl>,
       <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <7796093C4B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Mar 03 at 20:48, James Simmons wrote:
> > > > Probably worst problem currently is cursor code: it calls imgblit from interrupt
> > > > context, and matroxfb's accelerated procedures are not ready to handle
> > > > such thing (patch hooks cursor call much sooner for primary mga head).
> > > 
> > > Fixed now. Also I have a patch that properly fixes image.depth = 0 hack. I 
> > > will post for people to test. Folks please test the code.
> > 
> > AFAIK you only fixed kmalloc problem. Or is cursor callback disallowed
> > while doing imgblit/copyarea/fillrect ?
> 
> Take a look at fb_get_buffer_offset in fbmem.c and tell me if it is 
> enough for you. I do plan to move to using a semaphore instead of a 
> spinlock tho. 

Problem is not with buffer. Problem is with accelerator... if you
are in the middle of fb_imageblit, reentering it through cursor code
(although with different arguments) is simplest way to kill it...

I hope that it is guarded against by generic console layer by disabling
cursor around putcs, but I'm not sure (and well, apparently there is
something wrong, as when I use accelerated imageblit with 2.5.66-current-bk,
sometime some portions of painted rectangles are missing, like if
info->pixmap buffer got swapped behind accel_putcs back...).

And looking at softcursor code and fb_get_buffer_offset, it looks to me 
that softcursor's fb_get_buffer_offset is nowhere compensated, so it
always expires with count == 0, without waiting for its users
(there is nothing to fbsync, putcs code still paints characters into
buffer to put them later to screen), rewritting characters bodies
with cursor data... (I'll not comment about current fb_get_buffer_offset
anymore, as you are rewritting it with semaphores; but current
implementation does not work, caller must disable interrupts from
call to fb_get_buffer_offset to its release, as otherwise you'll deadlock
if you'll remove count==1000 limitation, because if same CPU
owns some portion of buffer while same CPU processes timer interrupt,
code which uses buffer will not make any progress while you are looping 
in the interrupt :-( And with (any) count limit you can just remove this
test completely.)

And I'm not sure that s_pitch/d_pitch order is correct in both
calls to move_buf_aligned in softcursor code - I think that both
calls should use same order of s/d pitch - but one uses s/d, while
other d/s.

But maybe that my analysis is completely wrong - I'm using dualhead
configuration, so I had to make couple of changes in cursor code
to have cursor on second head, and there is definitely something wrong
in this, as software underlined cursor looks like '_._' on secondary
head (it looks to me like binary value 0x6B, malloc filler value,
but I want to be sure before claiming it is your problem, but it
looks to me like that 'data' kmalloced in accel_cursor are not set 
to any value if FB_CUR_SETSIZE was not set, but softcursor code 
uses cursor->image.data always, regardless of FB_CUR_SETSHAPE).

[well, what's cursor->image.data argument supposed to do anyway
at fbops->fb_cursor interface? it looks to me like that it should
be array filled with 0xFF all the time]

And soft_cursor() may call kmalloc(GFP_KERNEL). Same rules as for
two kmallocs in accel_cursor() should apply: GFP_ATOMIC & check
return value (& I would preffer growing-only buffer instead of
reallocating it at every SETSHAPE request - preferrably only
on FB_CUR_SETSIZE).
                                                    Petr Vandrovec
                                                    

