Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbSLMBpg>; Thu, 12 Dec 2002 20:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267601AbSLMBpg>; Thu, 12 Dec 2002 20:45:36 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:11687 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S267599AbSLMBpb>;
	Thu, 12 Dec 2002 20:45:31 -0500
Date: Fri, 13 Dec 2002 02:53:06 +0100
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tcpv4: convert /proc/net/tcp to seq_file
Message-ID: <20021213015306.GD6682@gagarin>
References: <20021124020046.GA29645@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021124020046.GA29645@conectiva.com.br>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18Mf0k-0003rT-00*Qk9XLtoXId6* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My netstat -nl on my a 2.5.51 machine seems to have caused some infinite loop
in listening_get_next. sysrq+t saying:

netstat       R current      0  4157   2742                     (NOTLB)
Call Trace:
 [<c0109ff1>] do_IRQ+0xbd/0x138
 [<c0108ab8>] common_interrupt+0x18/0x20
 [<c02257f0>] listening_get_next+0x180/0x1c4
 [<c0225b68>] tcp_seq_next+0x40/0xa0
 [<c0158408>] seq_read+0x1d4/0x28c
     
Machine is ipv4+6. And there are services listening on both. The 5 entries
that it managed to print were ipv4 entries only.

--
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

On Sun, Nov 24, 2002 at 12:00:46AM -0200, Arnaldo Carvalho de Melo wrote:
> +static void *listening_get_next(struct seq_file *seq, void *cur)
> +{
> +	struct tcp_opt *tp;
> +	struct sock *sk = cur;
> +	struct tcp_iter_state* st = seq->private;
> +
> +	if (st->state == TCP_SEQ_STATE_OPENREQ) {
> +		struct open_request *req = cur;
> +
> +	       	tp = tcp_sk(st->syn_wait_sk);
> +		req = req->dl_next;
> +		while (1) {
> +			while (req) {
> +				++st->num;
> +				if (TCP_INET_FAMILY(req->class->family)) {
> +					cur = req;
> +					goto out;
> +				}
> +				req = req->dl_next;
> +			}
> +			if (++st->sbucket >= TCP_SYNQ_HSIZE)
> +				break;
> +get_req:
> +			req = tp->listen_opt->syn_table[st->sbucket];
> +		}
> +		sk	  = st->syn_wait_sk->next;
> +		st->state = TCP_SEQ_STATE_LISTENING;
> +		read_unlock_bh(&tp->syn_wait_lock);
> +	} else
> +		sk = sk->next;
> +get_sk:
> +	while (sk) {
> +		if (TCP_INET_FAMILY(sk->family)) {
> +			cur = sk;
> +			goto out;
> +		}
> +	       	tp = tcp_sk(sk);
> +		read_lock_bh(&tp->syn_wait_lock);
> +		if (tp->listen_opt && tp->listen_opt->qlen) {
> +			st->uid		= sock_i_uid(sk);
> +			st->syn_wait_sk = sk;
> +			st->state	= TCP_SEQ_STATE_OPENREQ;
> +			st->sbucket	= 0;
> +			goto get_req;
> +		}
> +		read_unlock_bh(&tp->syn_wait_lock);
> +	}
> +	if (++st->bucket < TCP_LHTABLE_SIZE) {
> +		sk = tcp_listening_hash[st->bucket];
> +		goto get_sk;
> +	}
> +	cur = NULL;
> +out:
> +	return cur;
> +}


