Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVJTTBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVJTTBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 15:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVJTTBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 15:01:04 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:51509 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932152AbVJTTBC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 15:01:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rQjkUR1C8CIuRGHSwxxNmsmjE+p/vruO5Ccdo8UQMj2+olrADALRUOP4usbfq1Mg9AlRAEAIwAEALorA7TinyvbYMXKH2O56nZklECwzvGUFzhhdpVRppUlec6A+AqpYaY2bX+cWmoqfQAjqSBlkzj9AjZnbOojfhXuB+/idsSc=
Message-ID: <4807377b0510201201i685efd46qf4c548da34b996cb@mail.gmail.com>
Date: Thu, 20 Oct 2005 12:01:01 -0700
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: ddaney@avtrex.com
Subject: Re: Patch: ATI Xilleon port 2/11 net/e100 Memory barriers and write flushing
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <17239.12568.110253.404667@dl2.hq2.avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17239.12568.110253.404667@dl2.hq2.avtrex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/05, David Daney <ddaney@avtrex.com> wrote:
> @@ -584,6 +584,7 @@ static inline void e100_write_flush(stru
>  {
>         /* Flush previous PCI writes through intermediate bridges
>          * by doing a benign read */
> +       wmb();
>         (void)readb(&nic->csr->scb.status);
>  }

I find it odd that this is needed, the readb is meant to flush all
posted writes on the pci bus, if your bus is conforming to pci
specifications, this must succeed.  wmb is for host side (processor
memory) writes to complete, and since we're usually only try to force
a writeX command to execute immediately with the readb (otherwise lazy
writes work okay) we shouldn't need a wmb *here*.  not to say it might
not be missing somewhere else.


> @@ -807,9 +808,13 @@ static inline int e100_exec_cmd(struct n
>                 goto err_unlock;
>         }
>
> -       if(unlikely(cmd != cuc_resume))
> +       wmb();
> +       if(unlikely(cmd != cuc_resume)) {
>                 writel(dma_addr, &nic->csr->scb.gen_ptr);
> +               e100_write_flush(nic);
> +       }
>         writeb(cmd, &nic->csr->scb.cmd_lo);
> +       e100_write_flush(nic);

wouldn't the last e100_write_flush be all that is needed?  e100 only
needs them to come in order, they don't need to be flushed one at a
time.

I can see how this change might be needed in a true write posting environment.

jesse
