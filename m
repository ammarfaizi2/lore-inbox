Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWFUQXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWFUQXJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWFUQXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:23:08 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:33607 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932218AbWFUQXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:23:07 -0400
Subject: Re: [PATCH] kprobes for s390 architecture
From: Jan Glauber <jan.glauber@de.ibm.com>
To: Mike Grundy <grundym@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       systemtap@sources.redhat.com
In-Reply-To: <20060612131552.GA6647@localhost.localdomain>
References: <20060612131552.GA6647@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 18:23:20 +0200
Message-Id: <1150907000.14295.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 09:15 -0400, Mike Grundy wrote:
> +int __kprobes arch_prepare_kprobe(struct kprobe *p)
> +{
> +	int ret = 0;
> +
> +	/* Make sure the probe isn't going on a difficult instruction */
> +	if (is_prohibited_opcode((kprobe_opcode_t *) p->addr))
> +		ret = -EINVAL;
> +
> +	/* Use the get_insn_slot() facility for correctness */
> +	if (!ret) {
> +		p->ainsn.insn = get_insn_slot();
> +		if (!p->ainsn.insn) {
> +			ret = -ENOMEM;
> +		} else {
> +			/* this should only happen if you got the slot */
> +			memcpy(p->ainsn.insn, p->addr,
> +			       MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
> +			p->ainsn.inst_type =
> +			    get_instruction_type(p->ainsn.insn);
> +		}
> +	}
> +	p->opcode = *p->addr;
> +	return ret;

I think we should also check for correct instruction alignment in this
function (2 bytes on s390), like:

if ((unsigned long)p->addr & 0x01) {
	printk("Attempt to register kprobe at an unaligned address\n");
	return -EINVAL;
}

Jan


---
Jan Glauber
IBM Linux Technology Center
Linux on zSeries Development, Boeblingen

