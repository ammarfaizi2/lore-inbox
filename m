Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSKIAOm>; Fri, 8 Nov 2002 19:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263293AbSKIAOm>; Fri, 8 Nov 2002 19:14:42 -0500
Received: from e004.dhcp212-198-142.noos.fr ([212.198.142.4]:60932 "EHLO
	mail.zigoo.net") by vger.kernel.org with ESMTP id <S263291AbSKIAOl>;
	Fri, 8 Nov 2002 19:14:41 -0500
Date: Sat, 9 Nov 2002 01:21:20 +0100
From: Thibaut VARENE <varenet@parisc-linux.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5 min()/max() macros generate warnings with gcc-3.0.4
Message-Id: <20021109012120.53dd8f55.varenet@parisc-linux.org>
Organization: ESIEE
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I'm currently trying to cleanup some warnings on 2.5 kernel tree, (especially on parisc files), and i noticed the following warnings when compiling with gcc-3.0.4:

mm/vmscan.c: In function `shrink_caches':
mm/vmscan.c:746: warning: duplicate `const'
mm/swap_state.c: In function `free_pages_and_swap_cache':
mm/swap_state.c:299: warning: duplicate `const'

in swap_state.c, the faulty line is:

	int todo = min(chunk, nr);

where chunk is "const int" and nr is "int".

min()/max() are defined in include/linux/kernel.h:145

Here is the preprocessed compiler output for swap_state.c regarding the faulty line:

	int todo = ({ const typeof(chunk) _x = (chunk); const typeof(nr) _y = (nr); (void) (&_x == &_y); _x < _y ? _x : _y; });

which should be read in particular as:
	int todo = ({ const typeof(const int chunk) _x = (const int chunk);
with types expanded.

Therefore, it seems that gcc doesn't like the redundancy of 'const' around 'typeof'.

But, according to C99, section 6.7.3 "Type qualifiers", paragraph 4, "if the same qualifier appears more than once in the same specifier-qualifier-list, [...] the behavior is the same as if it appeared only once."

So gcc shouldn't be complaining...

FWIW, casting as follow solves the warning but it definitly _evil_, since we lose const'ness:

	int todo = min((int)chunk, nr);

HTH,


Thibaut VARENE
The PA/Linux ESIEE Team
http://pateam.esiee.fr/

PS: please CC me when answering.
