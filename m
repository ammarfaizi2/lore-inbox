Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbSKOFML>; Fri, 15 Nov 2002 00:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbSKOFML>; Fri, 15 Nov 2002 00:12:11 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:267
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265786AbSKOFML>; Fri, 15 Nov 2002 00:12:11 -0500
Date: Fri, 15 Nov 2002 00:12:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Corey Minyard <cminyard@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework
In-Reply-To: <3DD47D0D.7080801@mvista.com>
Message-ID: <Pine.LNX.4.44.0211142354030.2750-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Corey Minyard wrote:

> RCU does.  Basically, the code pulls it from the list atomically wrt to 
> the NMI handler, and uses RCU to schedule the actual free of the data to 
> be done after all CPUs have gone to idle or returned from interrupts. 
>  It's subtle, you have to think about it a little.  But it does work.

Still not convinced, i still want to know which interrupt rate and how 
many processors. Are the following functions really protected from say 
NMIs at 300,000/s? request_nmi actually looks dodgiest.

static void free_nmi_handler(void *arg)
{
	struct nmi_handler *handler = arg;

	INIT_LIST_HEAD(&(handler->link));
	complete(&(handler->complete));
}

void release_nmi(struct nmi_handler *handler)
{
	spin_lock(&nmi_handler_lock);
	list_del_rcu(&(handler->link));
	init_completion(&(handler->complete));
	call_rcu(&(handler->rcu), free_nmi_handler, handler);
	spin_unlock(&nmi_handler_lock);
}

-- 
function.linuxpower.ca






