Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUCBDI6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 22:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbUCBDI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 22:08:58 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:7492 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261528AbUCBDI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 22:08:56 -0500
Date: Mon, 1 Mar 2004 19:08:16 -0800
From: Paul Jackson <pj@sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: jsimmons@infradead.org, arief_m_utama@telkomsel.co.id,
       linux-kernel@vger.kernel.org
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
Message-Id: <20040301190816.5ed4e241.pj@sgi.com>
In-Reply-To: <1078187189.21575.165.camel@gaston>
References: <Pine.LNX.4.44.0403020019340.7718-100000@phoenix.infradead.org>
	<1078187189.21575.165.camel@gaston>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > we have 2 choices

Hare-brained idea for 3rd choice - a pair of memcmp's, one on the early
part of struct fb_var_screeninfo before the activate field, the 2nd on
the remainder of that struct, after the activate field.

#include <stddef.h>

/*
 * Compare two structs of type TYPE, except for structure member MEMBER.
 * Return is < 0, 0 or > 0, just like memcmp().
 */

#define memcmp_all_but(s1, s2, TYPE, MEMBER)		\
	do { 						\
		return _memcmp_all_but(			\
			s1, s2, sizeof(TYPE),		\
			offsetof(TYPE, MEMBER),		\
			sizeof((TYPE *)0)->MEMBER);	\
	} while (0)

/*
 * Same as memcmp(s1, s2, n), except excludes the 'msz' bytes
 * starting at 'moffset' bytes from the comparison.  The 'm'
 * in 'msz', and 'moffset' stands for Member of structure.
 */

int _memcmp_all_but(const void *s1, const void *s2, size_t n, moffset, msz)
{
	int i;
	i = memcmp(s1, s2, moffset);
	if (i != 0)
		return i;
	return memcmp((char *)s1+moffset+msz, (char *)s2+moffset+msz, n-moffset-msz)
}

...

	if ((var->activate & FB_ACTIVATE_FORCE) ||
		memcmp_all_but(&info->var, var, struct fb_var_screeninfo, activate)) {

...

The above code is untried, untested, and probably insane.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
