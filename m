Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUHPEty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUHPEty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 00:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUHPEty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 00:49:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13752 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267424AbUHPEtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 00:49:50 -0400
Date: Mon, 16 Aug 2004 06:51:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816045110.GA15841@elte.hu>
References: <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net> <20040816024314.GA8960@elte.hu> <20040816030818.GA10685@elte.hu> <1092629953.810.23.camel@krustophenia.net> <20040816042653.GA14738@elte.hu> <1092630624.810.30.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <1092630624.810.30.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Lee Revell <rlrevell@joe-job.com> wrote:

> This was caused by 'Actions -> Run -> rxvt':

>  0.001ms (+0.000ms): pte_alloc_map (copy_page_range)
>  0.205ms (+0.204ms): do_IRQ (common_interrupt)

>  0.228ms (+0.000ms): preempt_schedule (copy_page_range)

>  0.399ms (+0.000ms): preempt_schedule (copy_page_range)
>  0.400ms (+0.000ms): check_preempt_timing (touch_preempt_timing)

seems we need a lock-break in the innermost loop of copy_page_range(). 
That loop processes up to 1024 pages currently, before the lock-break in
the outer loop happens. Large GUI processes are more likely to have full
4MB regions mapped & populated.

i suspect you could trigger a similarly bad latency by doing a fork() in
mlockall-test.cc - the attached mlockall-test2.cc does this. Do you get
bad latencies?

	Ingo

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mlockall-test2.cc"

// here is the code i used to test the mlockall caused xruns
#include <sys/mman.h>
#include <iostream>
#include <sstream>
#include <unistd.h>

int main (int argc, char *argv[]) {
        if (argc < 2) {
                std::cout << "how many kbytes you want allocated and mlockall'ed?" << std::endl;
        }

        std::stringstream stream(argv[1]);
        int kbytes;
        stream >> kbytes;
        char *mem = new char[kbytes*1024];
        std::cout << "filling with 0's" << std::endl;
        for (int i = 0; i < kbytes*1024; ++i) {
                mem[i] = 0;
        }

        std::cout << "ok, you want " << kbytes << "kb of memory mlocked.  going for it.." << std::endl;
        int error = mlockall(MCL_CURRENT);
        if (error != 0) { std::cout << "mlock error" << std::endl; }
        else { std::cout << "mlock successfull" << std::endl;}
	fork();
}


--YiEDa0DAkWCtVeE4--
