Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271386AbSISPXE>; Thu, 19 Sep 2002 11:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271485AbSISPXE>; Thu, 19 Sep 2002 11:23:04 -0400
Received: from fermat.math.technion.ac.il ([132.68.115.6]:30343 "EHLO
	fermat.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S271386AbSISPXD>; Thu, 19 Sep 2002 11:23:03 -0400
Date: Thu, 19 Sep 2002 18:28:01 +0300
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: linux-kernel@vger.kernel.org
Subject: weird code (bug?) in IP options handling
Message-ID: <20020919152801.GA2762@fermat.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Hebrew-Date: 14 Tishri 5763
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While browsing the ip-options setting code in Linux 2.4-18, I came across
the following peculiar code in net/ipv4/ip_options.c in ip_options_compile.
The code is apparently used when a setsockopt(fd, SOL_IP, IP_OPTIONS,...)
is called and one of the options is IPOPT_END (0):

        for (l = opt->optlen; l > 0; ) {
                switch (*optptr) {
                      case IPOPT_END:
                        for (optptr++, l--; l>0; l--) {
                                if (*optptr != IPOPT_END) {
                                        *optptr = IPOPT_END;
                                        opt->is_changed = 1;
                                }
                        }
                        goto eol;
	...

I am *guessing* that this piece of code was meant to zero (assign as
IPOPT_END) all option bytes after the first IPOPT_END. However, this is
not what actually happens in this code. In this code, only a single
byte after the first IPOPT_END (optptr++) is zeroed, and this same
assignment is done many times in a loop! This can't have been intended :)

I am guessing that this is just a programming error, and the programmer
perhaps intended to make the assignment in the inner for loop as

	*optptr = IPOPT_END;

Who's in charge for this code and can perhaps take a look at it?

By the way, I wonder: why zero the options at all? Why not simply leave
all option bytes after the first IPOPT_END as-is?

-- 
Nadav Har'El                        |    Thursday, Sep 19 2002, 14 Tishri 5763
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |If you tell the truth, you don't have to
http://nadav.harel.org.il           |remember anything.
