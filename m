Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWJDPwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWJDPwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161259AbWJDPwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:52:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:10 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1161254AbWJDPwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:52:16 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,256,1157353200"; 
   d="scan'208"; a="140351738:sNHT45327415"
Message-ID: <4082.10.24.212.168.1159977123.squirrel@linux.intel.com>
In-Reply-To: <20061004080637.0bd19042.pj@sgi.com>
References: <200610030816.27941.reinette.chatre@linux.intel.com>
    <20061003163936.d8e26629.akpm@osdl.org>
    <20061004141405.GA22833@tsunami.ccur.com>
    <20061004072746.8e4b97a0.pj@sgi.com>
    <20061004145524.GA24335@tsunami.ccur.com>
    <20061004080637.0bd19042.pj@sgi.com>
Date: Wed, 4 Oct 2006 08:52:03 -0700 (PDT)
Subject: Re: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of 
     a user buffer
From: inaky@linux.intel.com
To: "Paul Jackson" <pj@sgi.com>
Cc: "Joe Korty" <joe.korty@ccur.com>, akpm@osdl.org,
       reinette.chatre@linux.intel.com, linux-kernel@vger.kernel.org,
       inaky@linux.intel.com
User-Agent: SquirrelMail/1.4.6-7.el4.centos4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Joe wrote:
>> I guess I am a sucker for no-transient-buffer (bufferless?)
>
> Ah - that explains Joe's preference for putting the actual implementing
> code in the user version - it gets to pull in the user string one
> char at a time, avoiding a malloc'd buffer.

I tend to gree w/ Joe there.

I wonder if a hybrid would be ok, although I the pseudo impl
I propose below is kind of dirty, but some people might find it
justified enough:

static
__bitmap_parse(const void *_buf, size_t size, enum { KERNEL, USER } type,
               unsigned long *dst, int nbits)
{
        const char __user *ubuf = _buf;
        const char *buf = _buf;
        ...
        switch(type) {
        case USER:
                if (get_user(c, ubuf++))
                        return -EFAULT;
                break;
        case KERNEL:
                c = *buf++;
                break;
        default:
                BUG();
        ...
}


int bitmap_parse(const char *buf, unsigned int buflen,
                 unsigned long *maskp, int nmaskbits) {
    return __bitmap_parse(buf, buflen, KERNEL, maskp, nmaskbits);
}


int bitmap_parse_user(const char __user *buf, unsigned int buflen,
                      unsigned long *maskp, int nmaskbits) {
    return __bitmap_parse(buf, buflen, USER, maskp, nmaskbits);
}


[that or exposing __bitmap_user() as a extern / EXPORT and putting
 bitmap_parse{,_user}() as an inline in the header file]

It's nitty-gritty, but it removes the kmalloc from the equation...

-- 
Inaky
