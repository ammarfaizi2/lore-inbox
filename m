Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263347AbTI2NZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 09:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTI2NZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 09:25:24 -0400
Received: from petasus.isw.intel.com ([192.55.37.196]:60150 "EHLO
	petasus.isw.intel.com") by vger.kernel.org with ESMTP
	id S263347AbTI2NZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 09:25:18 -0400
Date: Mon, 29 Sep 2003 15:25:19 +0200 (CEST)
From: Artur Klauser <Artur.Klauser@computer.org>
To: linux-kernel@vger.kernel.org
cc: Artur Klauser <Artur.Klauser@computer.org>
Subject: div64.h:do_div() bug
Message-ID: <Pine.LNX.4.51.0309291503030.7947@enm.xynhfre.bet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found that a bug in asm-arm/div64.h:do_div() is preventing correct
conversion of timestamps in smbfs (and probably ntfs as well) from NT to
Unix format. I'll post a patch that fixes the bug, but I think it is also
present in other architectures - at least SPARC, SH, and CRIS look
suspicious.

If people with access to these architectures could run the following small 
test and let me know the outcome, I can fix it there too - thanks.

//-----------------------------------------------------------------------------
#define __KERNEL__
#include <asm/types.h> // get kernel definition of u64, u32
#undef __KERNEL__
#include <asm/div64.h> // get definition of do_div()
#include <stdio.h>

main () {
  union {
    u64 n64;
    u32 n32[2];
  } in, out;

  in.n32[0] = 1;
  in.n32[1] = 1;
  out = in;

  do_div(out.n64, 1);

  if (in.n64 != out.n64) {
    printf("FAILURE: asm/div64.h:do_div() is broken for 64-bit dividends\n");
    exit(1);
  } else {
    printf("Congratulations: asm/div64.h:do_div() handles 64-bit dividends\n");
  }
  return 0;
}
//-----------------------------------------------------------------------------
