Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265968AbRGAXFK>; Sun, 1 Jul 2001 19:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266080AbRGAXE7>; Sun, 1 Jul 2001 19:04:59 -0400
Received: from imladris.infradead.org ([194.205.184.45]:9234 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S265968AbRGAXEv>;
	Sun, 1 Jul 2001 19:04:51 -0400
Date: Mon, 2 Jul 2001 00:04:22 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Russell King <rmk@arm.linux.org.uk>, Adam J Richter <adam@yggdrasil.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs 
In-Reply-To: <6794.993956413@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.33.0107012309340.18977-101000@infradead.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-842912328-999166597-994028662=:18977"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---842912328-999166597-994028662=:18977
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Keith.

I don't agree with your analysis in the first block quoted below, but
that's not relevant as I feel there's a better solution than either of
the ones proposed so far. See below for details...

 >> 1. Adam's point is that there are dep_* statements in the config
 >>    setup that have been used to say that a particular option is
 >>    dependant upon a particular architecture, but this doesn't work.
 >>
 >> 3. MY understanding of the situation is that ALL architecture
 >>    specific config lines are EXPECTED to be in the arch/*/config.in
 >>    files, where they will only even be seen when the relevant
 >>    architecture is being compiled for.
 >>
 >> As a result of this, I would summarise this discussion as saying
 >> that there is a bug in the kernel config scripts in that some
 >> options that should be located in the architecture-specific
 >> config files are in the all-architecture config files instead.

 > (1) and (3) are correct but your conclusion is not. The problem is
 >
 >   dep_tristate CONFIG_some_driver $CONFIG_some_arch
 >
 > where the intention is to allow the driver only if some_arch is
 > set.

Can I suggest you re-read your comment and the points you quoted and
said are correct. As a DIRECT logical consequence of "(1) and (3) are
correct" (as you phrased it), we get the conclusion that any config
lines that depend on "if some arch is set" (as you phrased it) are in
the architecture-specific config files. This leads DIRECTLY to the
conclusion that ANY lines dependant on a particular architecture that
are not in the architecture-specific config files are a bug in the
kernel config scripts.

=======================================================================

Personally, I would suggest that the bug in this case is the actual
assumption that (3) is true, and the correct course of action is to
remove that assumption as it leads directly to the spaghetti in the
configuration system that we currently have.

 > When you compile for some_other_arch, CONFIG_some_arch is
 > undefined. dep_tristate treats undefined variables as "don't
 > care"...

Agreed - and whoever did the config lines where the dependancy is an
arch variable made the mistake of misunderstanding that.

 > ...and we cannot fix that without changing bash or a major
 > rewrite of the shell scripts.

Why is either needed? As I see it, the cure is to define a pair of new
statement types in the config language, as follows:

 1. dep_arch_bool CONFIG_var CONFIG_arch [CONFIG_other_var...]

    This states that CONFIG_var is a boolean var that depends both on
    CONFIG_arch being specifically "y" and on CONFIG_other_var being
    such as to satisfy dep_bool as currently.

 2. dep_arch_tristate CONFIG_var CONFIG_arch [CONFIG_other_var...]

    This is the tristate version of dep_arch_bool as expected.

When we've done that, ALL of the problem lines can be trivially
converted from dep_ to dep_arch_ and the problem vanishes. As a free
bonus, the need for the arch-specific config files vanishes as well,
and each option can be documented as to what architectures it is valid
for. This thus removes a possible source of bugs from the equation.

The enclosed patch (against 2.4.5 raw) adds these two statements to
both the `make config` and `make menuconfig` scripts. I don't
understand TCL/TK so can't add them to the `make xconfig` script, and
as I also don't understand PERL, I can't add it to `make checkconfig`
so somebody else will need to deal with those two scripts.

 > There are two solutions, either change all such lines to
 >
 >   if [ "$CONFIG_some_arch" = "y" ];then
 >     tristate CONFIG_some_driver
 >   fi
 >
 > or
 >
 >   define_bool CONFIG_some_arch n
 >
 > for all architectures at the start, followed by turning on the
 > one that is required.

Both are messy, and best described as kludges. I wouldn't support
either.

 > Lots of if statements are messy and they will not prevent
 > somebody adding new options with exactly the same problem.

Agreed.

 > Explicitly setting all but one arch variable to 'n' results in
 > cleaner config scripts and new arch dependent driver settings
 > will automatically work.

Until somebody adds a new port and fails to upgrade any one of the
various files doing this. That's an open recipe for bugs IMHO, and
should be avoided at all costs.

Best wishes from Riley.

---842912328-999166597-994028662=:18977
Content-Type: APPLICATION/x-gzip; name="linux-2.4.5-dep-arch.diff.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107020004220.18977@infradead.org>
Content-Description: Configure and Menuconfig patch
Content-Disposition: attachment; filename="linux-2.4.5-dep-arch.diff.gz"

H4sICPSpPzsCA2xpbnV4LTIuNC41LWRlcC1hcmNoLmRpZmYA1VVtb9s2EP5s
/4qDY2AOLKuWZCe11xYeugFrgPRD+2EYhiGg5ZNFVCYdkYrtFe1v3x0px29x
sBXbgBmGRJG8493z3D3s9XpQSFWte3E4CIcvTFrKpTUv3mqVyXlV4tfGx0rB
j5hCEkE/HkdX4yiBuN/vN7vd7vO2zvSmKgAiiJPxIBn3nWnUnEygN3gZXEGX
nlEfJpMmXNAf4gHcCFWJcgPRaDQK4FamucACfirkH2KKNoe3uTBWSBXAqwWm
E5PryoYK7Ru278G7xbLUDwg2R8C1tLBAY8QcoXODWQYftFJ4GTa7F/SnuCi8
jYspgA+ywA38DL/IopBiYeBVma8mC1yIYpmLMF2/YZMe/DCbwQyXd6JM87up
1gUItTdjS0nxWQT3XKCyBqymeLRBdgBgquVSlxZnMN3QvDTgoQubUMNwKz6R
PUEIK/yOniWKguIsK6WkmsNUmDx0IMZJxCjGyTCIYwfjF++EDjqNqMT7SpZI
8eTCOoQyWRoLemmlVkBgkQ2qmQH+MtDatNgRp6dpd7mShkwqlfJ2A8K4Mx7d
d6ZY6FUN7nbbE2F0LuFzs9u4r9C8brUjOqPxIEoaxjzkvTROeGxymVlIaCQz
+A1abV5swWuODH7/nlNQtNg4CKPVZs8tepNXfk3YFRYMP2/NpELP23aH4g2Z
bHa/NLscPFwcJkYVlVIVEXACHidFOa+YXQ/mFrhqqRXbC+UQ20KrtyMTArzL
aHkDOnMU1PPEdO3E+WD4BTta6FlVYOBS9fsVVQKVg16JabEzF1Qmt3zO+/qE
onBzv3pTXy0jVy1JFAXRS1ctDSpHShw8PO7zDI77CJ1y6+Dc57Ud1ay24y2n
7eQpRpMW9PAeNsd01gR9A5XAgbo+6J1Rt1tUVepUysvbrWANgH40HlyPh0Ov
UefkbWd8pG/DZBxHO327HjDW9Bx5efPaVDhFoNZXuNq10hjqXLbgdy6D7ZRU
du8rxzV9sTvYThkyUnO/x+PWoR6kHdy7/X9V4pyuIXg4DgSPesKLndM3yy5K
TPVckYQYJ3SsUq4o+yMnYVEcEHweKv/j8lVoCK3Aa5DCuh32lYzbEw2qFLmj
jF7QJUF47NxwuYD0zfMJS4VFWCsk/A2N9L0pVLqBKXWVC0gYQxJgtonSfu5a
BexRWkwtK7hZYiozieX/XBfhIPLDoGEvaNgF7W8od8/Hw6t9ej+KBfL9IaZ0
VwcwrSwovfLa5rF97+h3Ooez+qohAojnjXfRkSGGXF7lzBkoXNtHUTaXT3A8
9VX4X/N7oo3/HLffLpLneN0F+wynUf/a9WwUUdNGA3+TNPBBFMc6BmxDjzX7
YEmmc882QI3R3s1wkvRxRbtUH3M9Xa1zdck2XLaNZ8u4YdDerUlzM12H7i6U
4/RHiU8/GezSd7cOhUAq5d4nQNTsrFt1KE9B4dX7r8FQU/oEBI8re+l7+I/S
37H9J4iiyroJDAAA
---842912328-999166597-994028662=:18977--
