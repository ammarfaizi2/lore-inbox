Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUHJIno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUHJIno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUHJInh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:43:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40428 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262279AbUHJIml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:42:41 -0400
Date: Tue, 10 Aug 2004 09:53:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040810075331.GB25238@elte.hu>
References: <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe> <1092117141.761.15.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <1092117141.761.15.camel@mindpipe>
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


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Mon, 2004-08-09 at 22:06, Lee Revell wrote:
> 
> > Same results here, the mlockall problem is not fixed by -O4:
> 
> Correction, those traces did not involve mlockall at all, but
> kmap_atomic and get_user_pages.
> 
> Here is another one I got starting jackd.  Never seen it before today.
> 
> (jackd/778): 14583us non-preemptible critical section violated 1100 us
> preempt threshold starting at schedule+0x55/0x5a0 and ending at
> schedule+0x2ed/0x5a0

can you trigger similar latencies via the attached mlock testcode?
(written by Florian. Run it as root.)

	Ingo

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mlockall-test.cc"

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
}


--rwEMma7ioTxnRzrJ--
