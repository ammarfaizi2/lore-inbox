Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUDDG6B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 01:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUDDG6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 01:58:01 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:48831 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262217AbUDDG56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 01:57:58 -0500
Date: Sat, 3 Apr 2004 22:57:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: remove bitmap_shift_*() bitmap length limits
Message-Id: <20040403225712.7d4acc86.pj@sgi.com>
In-Reply-To: <20040401144234.2ef3c205.pj@sgi.com>
References: <20040330065152.GJ791@holomorphy.com>
	<20040330073604.GK791@holomorphy.com>
	<20040330081142.GL791@holomorphy.com>
	<20040401133033.435a3857.pj@sgi.com>
	<20040401144234.2ef3c205.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was one bug in my untested code for simple bitmap shifts,
the left shift needs to scan downwards, not upwards, so as to
avoid clobbering the input if shifting inplace.

The total text size of my user level test program is actually
made smaller with this per-bit simple implementation, as compared
to the implementation currently in the kernel, by 80 bytes.

Bill Irwin's more sophisticated version grows the text size,
over the current implementation, by 304 bytes.  This is on
Pentium pc, gcc version 3.3.2, compiled -O2.

Given the very rare usage this bitmap shift routines receive,
I cast my vote for small and simple.

The more sophisticated logic of Bill's implementation is
impressive, but unjustified in this situation, in my view.

My fixed shift functions are:

lib/bitmap.c:
=============

    static void _setbitval(unsigned long *dst,
			    unsigned int n, int val, unsigned int nbits)
    {
	    if (n >= nbits)
		    return;
	    if (val)
		    set_bit(n, dst);
	    else
		    clear_bit(n, dst);
    }

    static int _getbitval(const unsigned long *src,
			    unsigned int n, unsigned int nbits)
    {
	    if (n >= nbits)
		    return 0;
	    return test_bit(n, src) ? 1 : 0;
    }

    void bitmap_shift_right(unsigned long *dst,
			    const unsigned long *src, int shift, int bits)
    {
	    int k;
	    for (k = 0; k < bits; k++)
		    _setbitval(dst, k, _getbitval(src, k+shift, bits), bits);
    }
    EXPORT_SYMBOL(bitmap_shift_right);

    void bitmap_shift_left(unsigned long *dst,
			    const unsigned long *src, int shift, int bits)
    {
	    int k;
	    for (k = bits-1; k >= 0; k--)
		    _setbitval(dst, k, _getbitval(src, k-shift, bits), bits);
    }
    EXPORT_SYMBOL(bitmap_shift_left);


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
