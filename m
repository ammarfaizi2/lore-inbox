Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265316AbUF2AG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUF2AG1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 20:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUF2AG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 20:06:27 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:59104 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S265316AbUF2AGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 20:06:05 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: <bvaughan@mindspring.com>
Date: Tue, 29 Jun 2004 10:06:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16608.45673.307911.340194@cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Oops, nfsd, networking 
In-Reply-To: message from Bill Vaughan on Monday June 28
References: <S264922AbUF1MSP/20040628121815Z+10@vger.kernel.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 28, bvaughan@mindspring.com wrote:
> NFSD crash at large MTU and odd wsize/rsize.
>  

Thanks for the report.  It is very odd.
It seems to be crashing in fs/nfsd/nfs3xdrc.:nfs3svc_decode_writeargs
at:

	while (len > args->vec[v].iov_len) {
		len -= args->vec[v].iov_len;
		v++;
		args->vec[v].iov_base = page_address(rqstp->rq_argpages[v]);
		args->vec[v].iov_len = PAGE_SIZE;
	}

It looks like rqstp->rq_argpages[v] is NULL, and that is causing the
oops.
Obviously, that shouldn't happen :-)

Would you be able to change that code to:
	while (len > args->vec[v].iov_len) {
		len -= args->vec[v].iov_len;
		v++;
		if (rqstp->rq_argpages[v] == NULL) {
			printk("NULL page at %d, c=%d al=%d l=%d pl=%d\n",
				v, args->count, args->len, len,	rqstp->rq_arg.len);
		        BUG();
		}
		args->vec[v].iov_base = page_address(rqstp->rq_argpages[v]);
		args->vec[v].iov_len = PAGE_SIZE;
	}

(i.e. add the if() { printk..} bit).
and tell me what gets printed out?

Thanks,
NeilBrown
