Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVIAQFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVIAQFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVIAQFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:05:46 -0400
Received: from admin.zirkelwireless.com ([209.216.203.65]:43150 "EHLO
	admin.zirkelwireless.com") by vger.kernel.org with ESMTP
	id S1030222AbVIAQFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:05:46 -0400
Message-ID: <4317268B.20306@tungstengraphics.com>
Date: Thu, 01 Sep 2005 10:04:27 -0600
From: Brian Paul <brian.paul@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: State of Linux graphics
References: <9e47339105083009037c24f6de@mail.gmail.com>	<1125422813.20488.43.camel@localhost>	<20050831063355.GE27940@tuolumne.arden.org>	<1125512970.4798.180.camel@evo.keithp.com>	<20050831200641.GH27940@tuolumne.arden.org>	<1125522414.4798.222.camel@evo.keithp.com>	<20050901015859.GA11367@tuolumne.arden.org>	<1125547173.4798.289.camel@evo.keithp.com>	<43171D33.9020802@tungstengraphics.com> <1125590991.15768.55.camel@localhost.localdomain>
In-Reply-To: <1125590991.15768.55.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2005-09-01 at 09:24 -0600, Brian Paul wrote:
> 
>>If the blending is for screen-aligned rects, glDrawPixels would be a 
>>far easier path to optimize than texturing.  The number of state 
>>combinations related to texturing is pretty overwhelming.
> 
> 
> As doom showed however once you can cut down some of the combinations
> particularly if you know the texture orientation is limited you can
> really speed it up.
> 
> Blending is going to end up using textures onto flat surfaces facing the
> viewer which are not rotated or skewed.

Hi Alan,

It's other (non-orientation) texture state I had in mind:

- the texel format (OpenGL has over 30 possible texture formats).
- texture size and borders
- the filtering mode (linear, nearest, etc)
- coordinate wrap mode (clamp, repeat, etc)
- env/combine mode
- multi-texture state

It basically means that the driver may have to do state checks similar 
to this to determine if it can use optimized code.  An excerpt from Mesa:

          if (ctx->Texture._EnabledCoordUnits == 0x1
              && !ctx->FragmentProgram._Active
              && ctx->Texture.Unit[0]._ReallyEnabled == TEXTURE_2D_BIT
              && texObj2D->WrapS == GL_REPEAT
	     && texObj2D->WrapT == GL_REPEAT
              && texObj2D->_IsPowerOfTwo
              && texImg->Border == 0
              && texImg->Width == texImg->RowStride
              && (format == MESA_FORMAT_RGB || format == MESA_FORMAT_RGBA)
	     && minFilter == magFilter
	     && ctx->Light.Model.ColorControl == GL_SINGLE_COLOR
	     && ctx->Texture.Unit[0].EnvMode != GL_COMBINE_EXT) {
	    if (ctx->Hint.PerspectiveCorrection==GL_FASTEST) {
	       if (minFilter == GL_NEAREST
		   && format == MESA_FORMAT_RGB
		   && (envMode == GL_REPLACE || envMode == GL_DECAL)
		   && ((swrast->_RasterMask == (DEPTH_BIT | TEXTURE_BIT)
			&& ctx->Depth.Func == GL_LESS
			&& ctx->Depth.Mask == GL_TRUE)
		       || swrast->_RasterMask == TEXTURE_BIT)
		   && ctx->Polygon.StippleFlag == GL_FALSE
                    && ctx->Visual.depthBits <= 16) {
		  if (swrast->_RasterMask == (DEPTH_BIT | TEXTURE_BIT)) {
		     USE(simple_z_textured_triangle);
		  }
		  else {
		     USE(simple_textured_triangle);
		  }
	       }
          [...]

That's pretty ugly.  Plus the rasterization code for textured 
triangles is fairly complicated.

But the other significant problem is the application has to be sure it 
has set all the GL state correctly so that the fast path is really 
used.  If it gets one thing wrong, you may be screwed.  If different 
drivers optimize slightly different paths, that's another problem.

glDrawPixels would be simpler for both the implementor and user.

-Brian
