Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129035AbRBETCt>; Mon, 5 Feb 2001 14:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbRBETCi>; Mon, 5 Feb 2001 14:02:38 -0500
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:40117 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S129035AbRBETCg>; Mon, 5 Feb 2001 14:02:36 -0500
Message-ID: <3A7EF8FE.6169BB52@alumni.caltech.edu>
Date: Mon, 05 Feb 2001 11:03:26 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Reply-To: dank@alumni.caltech.edu
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mathieu_dube@videotron.ca, linux-kernel@vger.kernel.org
Subject: Re: No buffer space available??
In-Reply-To: <01020512555302.10576@therver.local2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Dube wrote:
>         when accept return -1 perror gives me "No buffer space available"
> What do you think that means??

Better ask a real net guru :-) 
Or look at the sources.

in /usr/src/linux/net/ipv4/af_inet.c

int inet_create() {
    ...
    sk = sk_alloc(PF_INET, GFP_KERNEL, 1);   
    if (sk == NULL)
        goto do_oom;  
    ...
    do_oom:
        return -ENOBUFS;   

in /usr/src/linux/net/core/sock.c

/*
 *  All socket objects are allocated here. This is for future
 *  usage.
 */
 
struct sock *sk_alloc(int family, int priority, int zero_it)
{
    struct sock *sk = kmem_cache_alloc(sk_cachep, priority);
 
    if(sk) {
        if (zero_it)
            memset(sk, 0, sizeof(struct sock));
        sk->family = family;
    }
 
    return sk;
}    

void __init sk_init(void)
{
    sk_cachep = kmem_cache_create("sock", sizeof(struct sock), 0,
                      SLAB_HWCACHE_ALIGN, 0, 0);
 
}     

Poking around a little in mm/slab.c, I see that the name passed to
kmem_cache_create is used in generating the /proc/slabinfo report, so 
  cat /proc/slabinfo   | grep sock
shows you some info.  On my system, it prints two numbers, from
        len += sprintf(buf+len, "%-17s %6lu %6lu\n", cachep->c_name, active_objs, num_objs);  
which tells you how many sockets are allocated.  Dunno how useful that is.

Like I said, you'll have to ask a real guru :-)

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
