Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUDAWnY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbUDAWnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:43:24 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:7626 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263124AbUDAWnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:43:21 -0500
Date: Thu, 1 Apr 2004 14:42:34 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: remove bitmap_shift_*() bitmap length limits
Message-Id: <20040401144234.2ef3c205.pj@sgi.com>
In-Reply-To: <20040401133033.435a3857.pj@sgi.com>
References: <20040330065152.GJ791@holomorphy.com>
	<20040330073604.GK791@holomorphy.com>
	<20040330081142.GL791@holomorphy.com>
	<20040401133033.435a3857.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill,

Here's roughly what I mean by slow and stupid (code untested, just a way
of presenting an alternative idea).  Perhaps my head is in a weird
place, but I find the following easier to understand.

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

    static int _getbitval(unsigned long *src, unsigned int n, unsigned int nbits)
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
	    for (k = 0; k < bits; k++)
		    _setbitval(dst, k, _getbitval(src, k-shift, bits), bits);
    }
    EXPORT_SYMBOL(bitmap_shift_left);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
