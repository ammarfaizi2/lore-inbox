Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265337AbRGEPM2>; Thu, 5 Jul 2001 11:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbRGEPMT>; Thu, 5 Jul 2001 11:12:19 -0400
Received: from pop.gmx.net ([194.221.183.20]:43759 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265336AbRGEPMJ>;
	Thu, 5 Jul 2001 11:12:09 -0400
Date: Thu, 5 Jul 2001 16:28:12 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010705162812.A602@marvin.mahowi.de>
Mail-Followup-To: Andrew Morton <andrewm@uow.edu.au>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3B4450DF.82EEC851@uow.edu.au>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.5 i686
X-Editor: VIM - Vi IMproved 5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

On Thu, 05 Jul 2001, Andrew Morton wrote:

> > kernel panic every time (see original post). My CPU is a MediaGX, and
> > Manfred's one is a 6x86MX. What about yours ?
> > After my first unsuccessful attempt with a 2.4.6-pre3, I tried several other
> > 2.4.6-preX and 2.4.5-acX kernels. All 2.4.6 (since pre1) seem to be
> > affected, and so do the latest ac's. I don't have tested 2.4.7-pre[12] yet,
> > but looking at the changelog, I doubt the fix is in.
> 
> 
> It may help to know which tasklet is in the wrong state.
> Could you please add this patch:
> 
> --- linux-2.4.6/kernel/softirq.c	Wed Jul  4 18:21:32 2001
> +++ lk-ext3/kernel/softirq.c	Thu Jul  5 21:32:08 2001
> @@ -202,8 +202,10 @@ static void tasklet_hi_action(struct sof
>  		if (!tasklet_trylock(t))
>  			BUG();
>  repeat:
> -		if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
> +		if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
> +			printk("func: %p\n", t->func);
>  			BUG();
> +		}
>  		if (!atomic_read(&t->count)) {
>  			local_irq_enable();
>  			t->func(t->data);
> 

Okay, here's the output of gdb:

(gdb) x/10i 0xc0118028
0xc0118028 <bh_action>: mov    0x4(%esp,1),%eax
0xc011802c <bh_action+4>:       cmpl   $0x0,0xc025c2e4
0xc0118033 <bh_action+11>:      jne    0xc0118043 <bh_action+27>
0xc0118035 <bh_action+13>:      mov    0xc024af20(,%eax,4),%eax
0xc011803c <bh_action+20>:      test   %eax,%eax
0xc011803e <bh_action+22>:      je     0xc0118042 <bh_action+26>
0xc0118040 <bh_action+24>:      call   *%eax
0xc0118042 <bh_action+26>:      ret
0xc0118043 <bh_action+27>:      lea    (%eax,%eax,4),%eax
0xc0118046 <bh_action+30>:      lea    0xc025bf80(,%eax,4),%eax

HTH,

Manfred
-- 
 /"\                        | PGP-Key available at Public Key Servers
 \ /  ASCII ribbon campaign | or "http://www.mahowi.de/pgp/mahowi.asc"
  X   against HTML mail     | RSA: 0xC05BC0F5 * DSS: 0x4613B5CA
 / \  and postings          | AIM: mahowi42   * ICQ: 61597169
