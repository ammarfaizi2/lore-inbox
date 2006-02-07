Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWBGQml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWBGQml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWBGQml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:42:41 -0500
Received: from holomorphy.com ([66.93.40.71]:19670 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1750808AbWBGQmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:42:40 -0500
Date: Tue, 7 Feb 2006 08:41:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process id namespace
Message-ID: <20060207164158.GB6789@holomorphy.com>
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com> <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com> <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 12:34:08PM -0700, Eric W. Biederman wrote:
> -#define mk_pid(map, off)	(((map) - pidmap_array)*BITS_PER_PAGE + (off))
> +#define mk_pid(map, off)	(((map) - pspace->pidmap)*BITS_PER_PAGE + (off))
>  #define find_next_offset(map, off)					\

mk_pid() should be:

#define mk_pid(pspace, map, off)	\
			(((map) - (pspace)->pidmap)*BITS_PER_PAGE + (off))

or otherwise made an inline; pscape escaping like this shouldn't happen.


On Mon, Feb 06, 2006 at 12:34:08PM -0700, Eric W. Biederman wrote:
> +static struct pspace *new_pspace(struct task_struct *leader)
> +{
> +	struct pspace *pspace, *parent;
> +	int i;
> +	size_t len;
> +	parent = leader->pspace;
> +	len = strlen(parent->name) + 10;
> +	pspace = kzalloc(sizeof(struct pspace) + len, GFP_KERNEL);
> +	if (!pspace)
> +		return NULL;
> +	atomic_set(&pspace->count, 1);
> +	pspace->flags        = 0;
> +	pspace->nr_threads   = 0;
> +	pspace->nr_processes = 0;
> +	pspace->last_pid     = 0;
> +	pspace->min          = RESERVED_PIDS;
> +	pspace->max          = PID_MAX_DEFAULT;
> +	for (i = 0; i < PIDMAP_ENTRIES; i++) {
> +		atomic_set(&pspace->pidmap[i].nr_free,  BITS_PER_PAGE);
> +		pspace->pidmap[i].page = NULL;
> +	}
> +	attach_any_pid(&pspace->child_reaper, leader, PIDTYPE_PID, 
> +			parent, leader->wid);
> +	leader->pspace->nr_processes++;
> +	snprintf(pspace->name, len + 1, "%s/%d", parent->name, leader->wid);
> +
> +	return pspace;
> +}

kzalloc() followed by zeroing ->flags et al by hand is redundant.


-- wli
