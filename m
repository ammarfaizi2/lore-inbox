Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132733AbRANNVl>; Sun, 14 Jan 2001 08:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132780AbRANNVb>; Sun, 14 Jan 2001 08:21:31 -0500
Received: from [213.253.36.78] ([213.253.36.78]:8714 "HELO
	blackhole.uknet.spacesurfer.com") by vger.kernel.org with SMTP
	id <S132733AbRANNVO>; Sun, 14 Jan 2001 08:21:14 -0500
Message-ID: <3A61A854.5243BD56@spacesurfer.com>
Date: Sun, 14 Jan 2001 13:23:32 +0000
From: Patrick <patrick@spacesurfer.com>
Reply-To: pim@uknet.spacesurfer.com
Organization: SpaceSurfer Ltd.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: Kernel oops in tcp_ipv4.c
In-Reply-To: <200101132029.f0DKTla156931@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not have the System map file for the kernel in question, all I have
is the config file and bzImage. In any case the map file will be useless
because the log file does not contain any register contents, stack
contents or byte code at the crash point. However, I do know which file
and function the oops occured in:
tcp_ipv4.c: __tcp_v4_hash

static __inline__ void __tcp_v4_hash(struct sock *sk)
{
	struct sock **skp;

	if (sk->pprev) { 
		printk("tcp_v4_hash: bug, socket state is %d\n", sk->state);
		*(int *)0 = 0;
	}
....

This function appears to add a new sock * struct (sk) to one of two hash
tables, one for sockets in the listen state and the other for sockets in
the connect state.
The above code appears to check if sk is already linked in to the list
of items in a hash table and if so causes a oops because it should be a
new sock *.

This inline function is called from tcp_v4_syn_recv_sock and
tcp_v4_hash. tcp_v4_hash is push in the hash element of a proto stuct
and appears to be called from the following functions in af_inet.c:
 inet_autobind
 inet_listen
 inet_create
 inet_bind
I don't think the oops is caused from cp_v4_syn_recv_sock, because this
function creates a new sock *, so it must be one of the others (or some
other call that I have missed!).
Any ideas?

"Albert D. Cahalan" wrote:
> 
> >>> Jan 11 21:10:06 ws2 kernel: tcp_v4_hash: bug, socket state is 1
> >>> Jan 11 21:10:06 ws2 kernel: Unable to handle kernel NULL pointer
> >>> dereference at virtual address 00000000
> >>> Jan 11 21:10:06 ws2 kernel: current->tss.cr3 = 0ca7c000, %cr3 = 0ca7c000
> >>> Jan 11 21:10:06 ws2 kernel: *pde = 00000000
> >>> Jan 11 21:10:06 ws2 kernel: Oops: 0002
> >>> Jan 11 21:10:06 ws2 kernel: CPU:    0
> ...
> >> You should post the full processed oops.. what the trap is there for ;-)
> ...
> > How do I process the oops? Are kernel core dumps generated when there is
> > an oops and if so where is the core file?
> 
> There isn't any core file, and we don't need one. The oops message
> itself contains most of the information that is needed. The rest
> of the information is in the System.map file that was created when
> you compiled your kernel. (also config info, CPU type, network
> setup, what you were running, etc.)
> 
> The System.map file is used to convert numbers into function names.
> It is what "ps -eo pid,comm,wchan" uses to print the WCHAN column.
> You might find it called /boot/System.map-2.2.18-ac4 if you were using
> the 2.2.18-ac4 kernel. (I forget what kernel you were using)
> 
> You can process the oops using the ksymoops program, or you can do
> it the hard way. Try ksymoops first I guess.
> 
> The hard way: look up each 8-digit hex number in the System.map file
> and report the name that is closest but not after the one you want.
> So you'd report foo if the address was c19384e5 and you had:
> 
> c193830c t before_foo
> c1938410 t foo
> c19384e8 t after_foo

-- 
Patrick Mackinlay                                patrick@spacesurfer.com
ICQ: 59277981                                        tel: +44 7050699851
                                                     fax: +44 7050699852
SpaceSurfer Limited                          http://www.spacesurfer.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
