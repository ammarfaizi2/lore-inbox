Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTJWS7S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 14:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTJWS7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 14:59:18 -0400
Received: from pat.uio.no ([129.240.130.16]:59595 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261685AbTJWS7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 14:59:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16280.9471.957832.641357@charged.uio.no>
Date: Thu, 23 Oct 2003 13:59:11 -0500
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre8
In-Reply-To: <20031023181251.GA5490@titan.lahn.de>
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
	<20031023181251.GA5490@titan.lahn.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Philipp Matthias Hahn <pmhahn@titan.lahn.de> writes:

     > make[3]: Entering directory `/usr/src/linux-2.4.23/net/sunrpc'
     > gcc -D__KERNEL__ -I/usr/src/linux-2.4.23/include -Wall
     > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
     > -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
     > -fno-optimize-sibling-calls -DMODULE -nostdinc -iwithprefix
     > include -DKBUILD_BASENAME=clnt -c -o clnt.o clnt.c clnt.c: In
     > function `call_verify': clnt.c:946: error: duplicate case value
     > clnt.c:926: error: previously used here clnt.c:951: error:
     > duplicate case value clnt.c:937: error: previously used here

There are no duplicate cases for the pre8 I just downloaded from
BitKeeper. Are you sure you haven't screwed up the patches?

Cheers,
  Trond

NOTE: The code in question should look as follows:

        switch ((n = ntohl(*p++))) {
        case RPC_SUCCESS:
                return p;
        case RPC_PROG_UNAVAIL:
                printk(KERN_WARNING "RPC: call_verify: program %u is unsupported by server %s\n",
                                (unsigned int)task->tk_client->cl_prog,
                                task->tk_client->cl_server);
                goto out_eio;
        case RPC_PROG_MISMATCH:
                printk(KERN_WARNING "RPC: call_verify: program %u, version %u unsupported by server %s\n",
                                (unsigned int)task->tk_client->cl_prog,
                                (unsigned int)task->tk_client->cl_vers,
                                task->tk_client->cl_server);
                goto out_eio;
        case RPC_PROC_UNAVAIL:
                printk(KERN_WARNING "RPC: call_verify: proc %u unsupported by program %u, version %u on server %s\n",
                                (unsigned int)task->tk_msg.rpc_proc,
                                (unsigned int)task->tk_client->cl_prog,
                                (unsigned int)task->tk_client->cl_vers,
                                task->tk_client->cl_server);
                goto out_eio;
        case RPC_GARBAGE_ARGS:
                break;                  /* retry */
        default:
                printk(KERN_WARNING "call_verify: server accept status: %x\n", n);
                /* Also retry */
        }

