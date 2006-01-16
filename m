Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWAPGAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWAPGAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 01:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWAPGAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 01:00:43 -0500
Received: from [203.2.177.25] ([203.2.177.25]:10811 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S932231AbWAPGAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 01:00:42 -0500
Subject: Re: 32 bit (socket layer) ioctl emulation for 64 bit kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Andi Kleen <ak@muc.de>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>, SP <pereira.shaun@gmail.com>
In-Reply-To: <200601131146.48128.arnd@arndb.de>
References: <1137045732.5221.21.camel@spereira05.tusc.com.au>
	 <200601121924.02747.arnd@arndb.de>
	 <1137122079.5589.34.camel@spereira05.tusc.com.au>
	 <200601131146.48128.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 16:59:20 +1100
Message-Id: <1137391160.5588.32.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd

I have made the changes suggested, and attached it below. I think it
should be good now.  
Just a couple of questions if I may. 
If I understand correctly from your comments (thanks for that, they are
helpful)
copy_to_user acts like a memcopy for an 'array' of bytes and should not
be used to copy the timeval struct to userspace. 
Rather put_user / __put_user macros should be used which allows transfer
of single element values of the structure. 
Does that also mean that copy_to_user should not be used in ioctl
calls? 

I was wondering if this the compat_sock_get_timestamp function is
needed? If I were to remove the SIOCGSTAMP case from the
compat_x25_ioctl function, then a SIOCGSTAMP ioctl system call would
return -ENOIOCTLCMD which could  then be handled by do_siocgstamp
handler in the ioctl32_hash_table? (fs/compat_ioctl.c)
In which case I could remove this patch from the rest of the series.
 
/Shaun


Index: linux-2.6.15/include/net/compat.h
===================================================================
--- linux-2.6.15.orig/include/net/compat.h
+++ linux-2.6.15/include/net/compat.h
@@ -23,6 +23,8 @@ struct compat_cmsghdr {
 	compat_int_t	cmsg_type;
 };
 
+extern int compat_sock_get_timestamp(struct sock *, struct timeval
__user *);
+
 #else /* defined(CONFIG_COMPAT) */
 #define compat_msghdr	msghdr		/* to avoid compiler warnings */
 #endif /* defined(CONFIG_COMPAT) */
Index: linux-2.6.15/net/compat.c
===================================================================
--- linux-2.6.15.orig/net/compat.c
+++ linux-2.6.15/net/compat.c
@@ -503,6 +503,25 @@ static int do_get_sock_timeout(int fd, i
 	return err;
 }
 
+int compat_sock_get_timestamp(struct sock *sk, struct timeval __user
*userstamp)
+{
+	struct compat_timeval __user *ctv
+		= (struct compat_timeval __user*) userstamp;
+	int err = -ENOENT;
+	if(!sock_flag(sk, SOCK_TIMESTAMP))
+		sock_enable_timestamp(sk);
+	if(sk->sk_stamp.tv_sec == -1)
+		return err;
+	if(sk->sk_stamp.tv_sec == 0)
+		do_gettimeofday(&sk->sk_stamp);
+	err = -EFAULT;
+	if(access_ok(VERIFTY_WRITE, ctv, sizeof(*ctv))) {
+		err = __put_user(sk->sk_stamp.tv_sec, &ctv->tv_sec);
+		err != __put_user(sk->sk_stamp.tv_usec, &ctv->tv_usec);
+	}
+	return err;
+}
+
 asmlinkage long compat_sys_getsockopt(int fd, int level, int optname,
 				char __user *optval, int __user *optlen)
 {
@@ -602,3 +621,5 @@ asmlinkage long compat_sys_socketcall(in
 	}
 	return ret;
 }
+
+EXPORT_SYMBOL(compat_sock_get_timestamp);


On Fri, 2006-01-13 at 11:46 +0000, Arnd Bergmann wrote:
> On Friday 13 January 2006 03:14, Shaun Pereira wrote:
> > Thank you for reviewing that bit of code.  
> > I had a look at compat_sys_gettimeofday and sys32_gettimeofday codes.
> > They seem to work in a similar way, casting a pointer to the structure
> > from user space to a compat_timeval type.
> 
> The part with the case is ok, except that you don't have to write
> 
> struct compat_timeval __user *ctv;
> ctv = (struct compat_timeval __user*) userstamp;
> 
> Instead,
> 
> struct compat_timeval __user *ctv = userstamp;
> 
> is the more common way to write it. The result is the same, since
> userstamp is a 'void __user *'.
> 
> > But to make sure I have tested the routine by forcing the sk-
> > >sk_stamp.tv_sec value to 0 in the x25_module ( for testing purposes
> > only, as it is initialised to -1). Now when
> > I make a 32 bit userspace SIOCGSTAMP ioctl to the 64 bit kernel I should
> > get the current time back in user space. This seems to work, the ioctl
> > returns the system time (just after TEST6:)
> > 
> > So I have left the patch as is for now. However if necessary to use
> > the element-by-element __put_user routine as in put_tv32, then I can
> > make the change, just let me know.
> 
> You need to to exactly that, yes. I'm not sure what exactly you have
> tested, but the expected result of your code would be that you see
> the sk_stamp.tv_sec value in the output, but not the tv_usec value.
> 
> On little-endian system like x86_64, that is not much of a difference
> (less than a second) that you might miss in a test case, but on
> big-endian, it would be fatal.
> 
> The layout of the structures on most systems is 
> 
> 		64 bit LE	64 bit BE	32 bit
> 
> bytes 0-3	tv_sec low	tv_sec high	tv_sec low
> bytes 4-7	tv_sec high	tv_sec low	tv_usec low
> bytes 8-11	tv_usec low	tv_usec high
> bytes 12-15	tv_usec high	tv_usec low
> 
> You code copies the first eight bytes of the 64 bit data structure
> into the 32 bit data structure.
> 
> 	Arnd <><

