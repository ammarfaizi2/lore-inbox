Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135247AbRAQMIo>; Wed, 17 Jan 2001 07:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135240AbRAQMIf>; Wed, 17 Jan 2001 07:08:35 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:7685 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S133035AbRAQMIW>;
	Wed, 17 Jan 2001 07:08:22 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Wed, 17 Jan 2001 13:07:29 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Killing process with SIGKILL and ncpfs
CC: marteen.deboer@iua.upf.es
X-mailer: Pegasus Mail v3.40
Message-ID: <12D4186E13AE@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Maarten de Boer pointed to me, that if you load some simple program,
such as 'void main(void) {}', trace into main (break main; run)
and then quit from gdb (Really exit? yes), child process is then
killed due to INT3 (probably). Then exit_mmap releases executable
mapping - and ncp_do_request is entered with SIGKILL pending!

Trace; d18e8822 <[ncpfs]ncp_do_request+1e2/1f8>
Trace; d18e88a5 <[ncpfs]ncp_request2+6d/a0>
Trace; d18e7c3c <[ncpfs]ncp_make_closed+9c/c8>
Trace; d18e332e <[ncpfs]ncp_release+a/1c>
Trace; c01349c1 <fput+39/e8>
Trace; c012566e <exit_mmap+da/124>
Trace; c0115e54 <mmput+38/50>
Trace; c011a134 <do_exit+d0/2a8>
Trace; c0108e10 <do_signal+234/28c>
Trace; c011f032 <force_sig_info+9a/a4>
Trace; c011f24d <force_sig+11/18>
Trace; c0109581 <do_int3+35/78>
Trace; c0109088 <error_code+34/3c>
Trace; c0108fa4 <signal_return+14/18>

So my question is:
(1) should ncpfs ignore ALL signals (even SIGKILL/SIGSTOP) when
    task is in PF_EXITING mode, or
(2) should kernel clear all pending signals at the beginning of do_exit or
(3) is it gdb bug that they forget 'int3' operation in traced program?

                                    Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
