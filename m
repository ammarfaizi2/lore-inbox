Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVD1LQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVD1LQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 07:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVD1LQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 07:16:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11210 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262041AbVD1LQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 07:16:00 -0400
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please check)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       vherva@viasys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <6.0.0.20.2.20050428151420.03d5c6f0@mailsv2.y.ecl.ntt.co.jp>
References: <20050326162801.GA20729@logos.cnet>
	 <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com>
	 <16968.40186.628410.152511@cse.unsw.edu.au>
	 <20050329215207.GE5018@logos.cnet>
	 <16970.9679.874919.876412@cse.unsw.edu.au>
	 <20050330115946.GA7331@logos.cnet>
	 <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
	 <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
	 <1113402868.3019.27.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114640549.4885.25.camel@sisko.sctweedie.blueyonder.co.uk>
	 <6.0.0.20.2.20050428151420.03d5c6f0@mailsv2.y.ecl.ntt.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114686919.1920.7.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 28 Apr 2005 12:15:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-04-28 at 09:54, Hifumi Hisashi wrote:
> At 07:22 05/04/28, Stephen C. Tweedie wrote:
>  >In checking out the patch one last time, though, I found one anomaly.
>  >The patch that was submitted to 2.6 for this problem also changed
>  >write_inode_now() to return an error value.  The patch that got
>  >submitted to 2.4 had no such change.  Was there a reason for this
>  >difference between the two versions?
> 
> Right. Also in ver 2.4, I know write_inode_now() has to be changed for perfect
> I/O error detection during synchronous writing.
> 
> In do_generic_file_write(mm/filemap.c), does the current return value handling is
> unchanged?

At present I'm using your changed version, but that is wrong --- in most
cases, we want to return short writes on errors.  It's only in the
synchronous case that we want to do otherwise, and even then only on EIO
on the inode.  For example, if we run out of quota halfway through an
O_SYNC write beyond EOF, then the bulk of the IO *has* completed
successfully, and we want to indicate that in the error.  So I'll be
re-jigging that bit of the code.

Cheers,
 Stephen

