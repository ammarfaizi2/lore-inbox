Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264906AbUGGEwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbUGGEwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 00:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264908AbUGGEwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 00:52:44 -0400
Received: from havoc.gtf.org ([216.162.42.101]:31393 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264906AbUGGEwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 00:52:39 -0400
Date: Wed, 7 Jul 2004 00:52:02 -0400
From: David Eger <eger@havoc.gtf.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040707045202.GA6536@havoc.gtf.org>
References: <20040706215622.GA9505@havoc.gtf.org> <Pine.LNX.4.53.0407062035040.16334@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0407062035040.16334@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 08:38:53PM -0400, Richard B. Johnson wrote:
> On Tue, 6 Jul 2004, David Eger wrote:
> 
> > Is there a reason to add the 'L' to such a 32-bit constant like this?
> > There doesn't seem a great rhyme to it in the headers...
> 
> Well if you put the 'name' so we could search for the reason.....

The reason I ask is that I'm going on a cleaning spree of 

include/video/radeon.h

I was trying to debug my code figuring out which flags we were 
setting in GMC_GUI_MASTER_CNTL.  Now radeon.h does have lots of
#defines for what the bits mean, but they're all mixed up, e.g.:

#define GMC_DP_CONVERSION_TEMP_6500                0x00000000
#define GMC_DP_SRC_RECT                            0x02000000
#define GMC_DP_SRC_HOST                            0x03000000
#define GMC_DP_SRC_HOST_BYTEALIGN                  0x04000000
#define GMC_3D_FCN_EN_CLR                          0x00000000
#define GMC_3D_FCN_EN_SET                          0x08000000
#define GMC_DST_CLR_CMP_FCN_LEAVE                  0x00000000
#define GMC_DST_CLR_CMP_FCN_CLEAR                  0x10000000
#define GMC_AUX_CLIP_LEAVE                         0x00000000
#define GMC_AUX_CLIP_CLEAR                         0x20000000
#define GMC_WRITE_MASK_LEAVE                       0x00000000
#define GMC_WRITE_MASK_SET                         0x40000000
#define GMC_CLR_CMP_CNTL_DIS                       (1 << 28)
#define GMC_SRC_DATATYPE_COLOR                     (3 << 12)
#define ROP3_S                                     0x00cc0000
#define ROP3_SRCCOPY                               0x00cc0000
#define ROP3_P                                     0x00f00000
#define ROP3_PATCOPY                               0x00f00000
#define DP_SRC_SOURCE_MASK                         (7    << 24)
#define GMC_BRUSH_NONE                             (15   <<  4)
#define DP_SRC_SOURCE_MEMORY                       (2    << 24)
#define GMC_BRUSH_SOLIDCOLOR                       0x000000d0

This mish-mash makes it impossible to grep for '0x00f0' or 
'0x000000f0' and get the answer I want, as GMC_BRUSH_NONE isn't 
listed in such a form.  So I wrote a little script to standardize
the file, and I noticed that in other sections, we have #defines
like these:

// CLK_PIN_CNTL
#define CLK_PIN_CNTL__OSC_EN_MASK                          0x00000001L
#define CLK_PIN_CNTL__OSC_EN                               0x00000001L
#define CLK_PIN_CNTL__XTL_LOW_GAIN_MASK                    0x00000004L
#define CLK_PIN_CNTL__XTL_LOW_GAIN                         0x00000004L
#define CLK_PIN_CNTL__DONT_USE_XTALIN_MASK                 0x00000010L
#define CLK_PIN_CNTL__DONT_USE_XTALIN                      0x00000010L

As part of the standardization, my script strips the 'L' off
of the constant.  (It's the output of 'eval()'ing the #define in 
Python.)  I was really just wondering if this would break anyone's
code.

Invocation goes like this:

$ (stdlbdef.py | upsidedown.py | stdlbdef.py | upsidedown.py ) < radeon.h > radeon.h.2

Then all of the simple arithmetic #define's are aligned to a uniform
width of hex value within each block of #define's.

-dte

#!/usr/bin/python
#
#  stdlbdef.py
#
# Got a header file where someone has mixed up their constants 
#  willy-nilly, like this?
#
#define GMC_AUX_CLIP_LEAVE                         0x00000000
#define GMC_AUX_CLIP_CLEAR                         0x20000000
#define GMC_WRITE_MASK_LEAVE                       0x00000000
#define GMC_WRITE_MASK_SET                         0x40000000
#define GMC_CLR_CMP_CNTL_DIS                       (1 << 28)
#define GMC_SRC_DATATYPE_COLOR                     (3 << 12)
#
# This script will make them all nice constants... mmmm..

import string
import re
import sys

linesplitter = re.compile("^(?P<a>#define\s+[a-zA-Z0-9_]+\s+)(?P<b>.*)")
hexnum = re.compile("^0[xX][0-9a-fA-F]+$")

l = sys.stdin.readline()
lastsize = 2

while l:
        ma = linesplitter.search(l,0)
        if ma and ma.group("b"):
                exp = ma.group("b").rstrip()
                # process the line
                if hexnum.match(exp,0) and len(exp) >= lastsize:
                        lastsize = len(exp)
                        sys.stdout.write( l )
                else:
                        try:
                                num = eval(exp)
                                q = '0x%x' % num
                                if len(q) < lastsize:
                                        fs = '0x%%0%dx' % (lastsize - 2)
                                        q = fs % num
                                lastsize = len(q)
                                sys.stdout.write( '%s%s\n' % (ma.group("a"), q))
                        except:
                                sys.stdout.write( l )
        else:
                sys.stdout.write( l )
                lastsize = 2
        l = sys.stdin.readline()


#!/usr/bin/python
#
# upsidedown.py
#
#   prints out a file, line by line, starting with the last line, 
#    going to the first

import sys
l = sys.stdin.readlines()
l.reverse()
for i in l:
        sys.stdout.write(i)

