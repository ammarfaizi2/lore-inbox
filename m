Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264718AbTFQN31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 09:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbTFQN31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 09:29:27 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:29322
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S264718AbTFQN3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 09:29:25 -0400
Date: Tue, 17 Jun 2003 09:43:19 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [SPARSE] seg fault problems.
Message-ID: <20030617134319.GN20872@michonline.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For a while now, I've been getting a segfault everytime I run "check"
(even on a tree without any of my hackery in it.)

The segfault is here:
0x0804ff15 in add_ptr_list (listp=0x80609c0, ptr=0x40a04f84) at lib.c:207
207             if (!list || (nr = list->nr) >= LIST_NODE_NR) {

This is why:
(gdb) p *listp
$1 = (struct ptr_list *) 0x1

Tracking things back, I get:
(gdb) bt
#0  0x0804ff15 in add_ptr_list (listp=0x80609c0, ptr=0x40a04f84) at lib.c:207
#1  0x0804b855 in add_symbol (list=0x80609c0, sym=0x40a04f84) at lib.h:71
#2  0x0804b486 in parse_function_body (token=0x4066094c, decl=0x40a04f84, list=0x80609c0) at parse.c:1081
#3  0x0804b609 in external_declaration (token=0x40660884, list=0x80609c0) at parse.c:1121
#4  0x0804b832 in translation_unit (token=0x406607d0, list=0x80609c0) at parse.c:1167
#5  0x08048d44 in main (argc=7, argv=0xbffff774) at check.c:178

check.c:178 is:
        translation_unit(token, &used_list);

Putting a watch on used_list==0x1, it changes from 0 to 1 here:

preprocessor_if (token=0x4022664c, true=0) at pre-process.c:683
683             if (false_nesting || !true) {

or more accurately, here:
        if (false_nesting || !true) {
                false_nesting++;
                return 1;
        }

I'm completely not understanding what's going on here - used_list goes
from 0x0 to 0x1 a lot, and it doesn't seem to fail except in a path that
triggers in a few cases.

Got anything else I can do to help track this down?

-- 

Ryan Anderson
  sometimes Pug Majere
