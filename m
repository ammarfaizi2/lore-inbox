Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934540AbWKXKO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934540AbWKXKO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 05:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934541AbWKXKO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 05:14:56 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:188 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S934540AbWKXKOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 05:14:55 -0500
Message-ID: <4566C519.1090902@openvz.org>
Date: Fri, 24 Nov 2006 13:10:33 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       matthltc@us.ibm.com, hch@infradead.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, oleg@tv-sign.ru, devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH 4/13] BC: context handling
References: <45535C18.4040000@sw.ru> <45535E11.20207@sw.ru>	 <6599ad830611222348o1203357tea64fff91edca4f3@mail.gmail.com>	 <45655D3E.5020702@openvz.org>	 <6599ad830611230053m7182698cu897abe5d19471aff@mail.gmail.com>	 <456567DD.6090703@openvz.org>	 <6599ad830611230131w1bf63dc1m1998b55b61579509@mail.gmail.com>	 <45657030.7050009@openvz.org> <6599ad830611230218w7a6c0c0el9479b497037b0be6@mail.gmail.com>
In-Reply-To: <6599ad830611230218w7a6c0c0el9479b497037b0be6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got it! That's what will work:

struct task_struct {
	...
	struct beancounter *exec_bc;
	struct beancounter *tmp_exec_bc; /* is set to NULL on
                                          * tsk creation
                                          */
};

struct beancounter get_exec_bc(void)
{
	if (current->tmp_exec_bc)
		return current->tmp_exec_bc;
	return rcu_dereference(current->exec_bc);
}


struct beancounter set_tmp_exec_bc(struct beancounter *new)
{
	struct beancounter *old;

	old = current->tmp_exec_bc;
	current->tmp_exec_bc = new;
	return old;
}

void reset_tmp_exec_bc(struct beancounter *expected_old)
{
	BUG_ON(current->tmp_exec_bc != expected_old);
	current->tmp_exec_bc = NULL;
}

void move_task(struct task_struct *tsk, struct beancounter *bc)
{
	struct beancounter *old;

	mutex_lock(&tsk_move_mutex);
	old = tsk->exec_bc;
	get_bc(bc);
	rcu_assign_pointer(current->exec_bc, bc);
	syncronize_rcu();
	mutex_unlock(&tsk_move_mutex);

	bc_put(old);
}

I will implement this in the next beancounter patches.
Thanks for discussion :)
