Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWHBMrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWHBMrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 08:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWHBMrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 08:47:12 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:48355 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750861AbWHBMrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 08:47:09 -0400
Subject: Re: [Patch] kernel memory leak fix for af_unix datagram getpeersec
	patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Catherine Zhang <cxzhang@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jmorris@namei.org,
       davem@davemloft.net, catalin.marinas@gmail.com,
       michal.k.k.piotrowski@gmail.com, czhang.us@gmail.com
In-Reply-To: <20060802064752.GA21407@jiayuguan.watson.ibm.com>
References: <20060802064752.GA21407@jiayuguan.watson.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 02 Aug 2006 08:49:42 -0400
Message-Id: <1154522982.16917.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 02:47 -0400, Catherine Zhang wrote:
> Hi, all,
> 
> Enclosed please find the updated patch incorporating comments from
> Stephen and Dave.

Note that this patch is intended for 2.6.18 as a bug fix for the memory
leak introduced by the original dgram peersec patches.

> Again thanks for your help!
> Catherine
> 
> --
> 
> 
> From: cxzhang@watson.ibm.com
> 
> This patch implements a cleaner fix for the memory leak problem of the original 
> unix datagram getpeersec patch.  Instead of creating a security context each
> time a unix datagram is sent, we only create the security context when the
> receiver requests it.
> 
> This new design requires modification of the current unix_getsecpeer_dgram
> LSM hook and addition of two new hooks, namely, secid_to_secctx and
> release_secctx.  The former retrieves the security context and the latter
> releases it.  A hook is required for releasing the security context because
> it is up to the security module to decide how that's done.  In the case of
> Selinux, it's a simple kfree operation.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
> 
> ---
> 
>  include/linux/security.h |   41 +++++++++++++++++++++++++++++++++++------
>  include/net/af_unix.h    |    6 ++----
>  include/net/scm.h        |   29 +++++++++++++++++++++++++----
>  net/ipv4/ip_sockglue.c   |    9 +++++++--
>  net/unix/af_unix.c       |   17 +++++------------
>  security/dummy.c         |   14 ++++++++++++--
>  security/selinux/hooks.c |   38 ++++++++++++++++++++++++--------------
>  7 files changed, 110 insertions(+), 44 deletions(-)
> 
> diff -puN include/net/scm.h~af_unix-datagram-getpeersec-ml-fix include/net/scm.h
> --- linux-2.6.18-rc2/include/net/scm.h~af_unix-datagram-getpeersec-ml-fix	2006-07-22 21:28:21.000000000 -0400
> +++ linux-2.6.18-rc2-cxzhang/include/net/scm.h	2006-08-01 22:43:50.000000000 -0400
> @@ -3,6 +3,7 @@
>  
>  #include <linux/limits.h>
>  #include <linux/net.h>
> +#include <linux/security.h>
>  
>  /* Well, we should have at least one descriptor open
>   * to accept passed FDs 8)
> @@ -20,8 +21,7 @@ struct scm_cookie
>  	struct ucred		creds;		/* Skb credentials	*/
>  	struct scm_fp_list	*fp;		/* Passed files		*/
>  #ifdef CONFIG_SECURITY_NETWORK
> -	char			*secdata;	/* Security context	*/
> -	u32			seclen;		/* Security length	*/
> +	u32			secid;		/* Passed security ID 	*/
>  #endif
>  	unsigned long		seq;		/* Connection seqno	*/
>  };
> @@ -32,6 +32,16 @@ extern int __scm_send(struct socket *soc
>  extern void __scm_destroy(struct scm_cookie *scm);
>  extern struct scm_fp_list * scm_fp_dup(struct scm_fp_list *fpl);
>  
> +#ifdef CONFIG_SECURITY_NETWORK
> +static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
> +{
> +	security_socket_getpeersec_dgram(sock, NULL, &scm->secid);
> +}
> +#else
> +static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
> +{ }
> +#endif /* CONFIG_SECURITY_NETWORK */
> +
>  static __inline__ void scm_destroy(struct scm_cookie *scm)
>  {
>  	if (scm && scm->fp)
> @@ -47,6 +57,7 @@ static __inline__ int scm_send(struct so
>  	scm->creds.pid = p->tgid;
>  	scm->fp = NULL;
>  	scm->seq = 0;
> +	unix_get_peersec_dgram(sock, scm);
>  	if (msg->msg_controllen <= 0)
>  		return 0;
>  	return __scm_send(sock, msg, scm);
> @@ -55,8 +66,18 @@ static __inline__ int scm_send(struct so
>  #ifdef CONFIG_SECURITY_NETWORK
>  static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
>  {
> -	if (test_bit(SOCK_PASSSEC, &sock->flags) && scm->secdata != NULL)
> -		put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, scm->seclen, scm->secdata);
> +	char *secdata;
> +	u32 seclen;
> +	int err;
> +
> +	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> +		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
> +
> +		if (!err) {
> +			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
> +			security_release_secctx(secdata, seclen);
> +		}
> +	}
>  }
>  #else
>  static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
> diff -puN net/unix/af_unix.c~af_unix-datagram-getpeersec-ml-fix net/unix/af_unix.c
> --- linux-2.6.18-rc2/net/unix/af_unix.c~af_unix-datagram-getpeersec-ml-fix	2006-07-22 23:01:26.000000000 -0400
> +++ linux-2.6.18-rc2-cxzhang/net/unix/af_unix.c	2006-08-02 02:25:00.454243480 -0400
> @@ -128,23 +128,17 @@ static atomic_t unix_nr_socks = ATOMIC_I
>  #define UNIX_ABSTRACT(sk)	(unix_sk(sk)->addr->hash != UNIX_HASH_SIZE)
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> -static void unix_get_peersec_dgram(struct sk_buff *skb)
> +static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>  {
> -	int err;
> -
> -	err = security_socket_getpeersec_dgram(skb, UNIXSECDATA(skb),
> -					       UNIXSECLEN(skb));
> -	if (err)
> -		*(UNIXSECDATA(skb)) = NULL;
> +	memcpy(UNIXSID(skb), &scm->secid, sizeof(u32));
>  }
>  
>  static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>  {
> -	scm->secdata = *UNIXSECDATA(skb);
> -	scm->seclen = *UNIXSECLEN(skb);
> +	scm->secid = *UNIXSID(skb);
>  }
>  #else
> -static inline void unix_get_peersec_dgram(struct sk_buff *skb)
> +static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>  { }
>  
>  static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
> @@ -1323,8 +1317,7 @@ static int unix_dgram_sendmsg(struct kio
>  	memcpy(UNIXCREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
>  	if (siocb->scm->fp)
>  		unix_attach_fds(siocb->scm, skb);
> -
> -	unix_get_peersec_dgram(skb);
> +	unix_get_secdata(siocb->scm, skb);
>  
>  	skb->h.raw = skb->data;
>  	err = memcpy_fromiovec(skb_put(skb,len), msg->msg_iov, len);
> diff -puN include/net/af_unix.h~af_unix-datagram-getpeersec-ml-fix include/net/af_unix.h
> --- linux-2.6.18-rc2/include/net/af_unix.h~af_unix-datagram-getpeersec-ml-fix	2006-07-22 23:41:05.000000000 -0400
> +++ linux-2.6.18-rc2-cxzhang/include/net/af_unix.h	2006-08-01 22:50:20.000000000 -0400
> @@ -54,15 +54,13 @@ struct unix_skb_parms {
>  	struct ucred		creds;		/* Skb credentials	*/
>  	struct scm_fp_list	*fp;		/* Passed files		*/
>  #ifdef CONFIG_SECURITY_NETWORK
> -	char			*secdata;	/* Security context	*/
> -	u32			seclen;		/* Security length	*/
> +	u32			secid;		/* Security ID		*/
>  #endif
>  };
>  
>  #define UNIXCB(skb) 	(*(struct unix_skb_parms*)&((skb)->cb))
>  #define UNIXCREDS(skb)	(&UNIXCB((skb)).creds)
> -#define UNIXSECDATA(skb)	(&UNIXCB((skb)).secdata)
> -#define UNIXSECLEN(skb)		(&UNIXCB((skb)).seclen)
> +#define UNIXSID(skb)	(&UNIXCB((skb)).secid)
>  
>  #define unix_state_rlock(s)	spin_lock(&unix_sk(s)->lock)
>  #define unix_state_runlock(s)	spin_unlock(&unix_sk(s)->lock)
> diff -puN include/linux/security.h~af_unix-datagram-getpeersec-ml-fix include/linux/security.h
> --- linux-2.6.18-rc2/include/linux/security.h~af_unix-datagram-getpeersec-ml-fix	2006-07-23 17:49:18.000000000 -0400
> +++ linux-2.6.18-rc2-cxzhang/include/linux/security.h	2006-08-01 23:30:32.000000000 -0400
> @@ -1109,6 +1109,16 @@ struct swap_info_struct;
>   *	@name contains the name of the security module being unstacked.
>   *	@ops contains a pointer to the struct security_operations of the module to unstack.
>   * 
> + * @secid_to_secctx:
> + *	Convert secid to security context.
> + *	@secid contains the security ID.
> + *	@secdata contains the pointer that stores the converted security context.
> + *
> + * @release_secctx:
> + *	Release the security context.
> + *	@secdata contains the security context.
> + *	@seclen contains the length of the security context.
> + *
>   * This is the main security structure.
>   */
>  struct security_operations {
> @@ -1289,6 +1299,8 @@ struct security_operations {
>  
>   	int (*getprocattr)(struct task_struct *p, char *name, void *value, size_t size);
>   	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t size);
> +	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
> +	void (*release_secctx)(char *secdata, u32 seclen);
>  
>  #ifdef CONFIG_SECURITY_NETWORK
>  	int (*unix_stream_connect) (struct socket * sock,
> @@ -1317,7 +1329,7 @@ struct security_operations {
>  	int (*socket_shutdown) (struct socket * sock, int how);
>  	int (*socket_sock_rcv_skb) (struct sock * sk, struct sk_buff * skb);
>  	int (*socket_getpeersec_stream) (struct socket *sock, char __user *optval, int __user *optlen, unsigned len);
> -	int (*socket_getpeersec_dgram) (struct sk_buff *skb, char **secdata, u32 *seclen);
> +	int (*socket_getpeersec_dgram) (struct socket *sock, struct sk_buff *skb, u32 *secid);
>  	int (*sk_alloc_security) (struct sock *sk, int family, gfp_t priority);
>  	void (*sk_free_security) (struct sock *sk);
>  	unsigned int (*sk_getsid) (struct sock *sk, struct flowi *fl, u8 dir);
> @@ -2059,6 +2071,16 @@ static inline int security_netlink_recv(
>  	return security_ops->netlink_recv(skb, cap);
>  }
>  
> +static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
> +{
> +	return security_ops->secid_to_secctx(secid, secdata, seclen);
> +}
> +
> +static inline void security_release_secctx(char *secdata, u32 seclen)
> +{
> +	return security_ops->release_secctx(secdata, seclen);
> +}
> +
>  /* prototypes */
>  extern int security_init	(void);
>  extern int register_security	(struct security_operations *ops);
> @@ -2725,6 +2747,15 @@ static inline void securityfs_remove(str
>  {
>  }
>  
> +static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void security_release_secctx(char *secdata, u32 seclen)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> @@ -2840,10 +2871,9 @@ static inline int security_socket_getpee
>  	return security_ops->socket_getpeersec_stream(sock, optval, optlen, len);
>  }
>  
> -static inline int security_socket_getpeersec_dgram(struct sk_buff *skb, char **secdata,
> -						   u32 *seclen)
> +static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
>  {
> -	return security_ops->socket_getpeersec_dgram(skb, secdata, seclen);
> +	return security_ops->socket_getpeersec_dgram(sock, skb, secid);
>  }
>  
>  static inline int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
> @@ -2968,8 +2998,7 @@ static inline int security_socket_getpee
>  	return -ENOPROTOOPT;
>  }
>  
> -static inline int security_socket_getpeersec_dgram(struct sk_buff *skb, char **secdata,
> -						   u32 *seclen)
> +static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
>  {
>  	return -ENOPROTOOPT;
>  }
> diff -puN security/selinux/hooks.c~af_unix-datagram-getpeersec-ml-fix security/selinux/hooks.c
> --- linux-2.6.18-rc2/security/selinux/hooks.c~af_unix-datagram-getpeersec-ml-fix	2006-07-24 00:55:21.000000000 -0400
> +++ linux-2.6.18-rc2-cxzhang/security/selinux/hooks.c	2006-08-01 23:58:17.000000000 -0400
> @@ -3524,25 +3524,21 @@ out:	
>  	return err;
>  }
>  
> -static int selinux_socket_getpeersec_dgram(struct sk_buff *skb, char **secdata, u32 *seclen)
> +static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
>  {
> +	u32 peer_secid = SECSID_NULL;
>  	int err = 0;
> -	u32 peer_sid;
>  
> -	if (skb->sk->sk_family == PF_UNIX)
> -		selinux_get_inode_sid(SOCK_INODE(skb->sk->sk_socket),
> -				      &peer_sid);
> -	else
> -		peer_sid = selinux_socket_getpeer_dgram(skb);
> -
> -	if (peer_sid == SECSID_NULL)
> -		return -EINVAL;
> +	if (sock && (sock->sk->sk_family == PF_UNIX))
> +		selinux_get_inode_sid(SOCK_INODE(sock), &peer_secid);
> +	else if (skb)
> +		peer_secid = selinux_socket_getpeer_dgram(skb);
>  
> -	err = security_sid_to_context(peer_sid, secdata, seclen);
> -	if (err)
> -		return err;
> +	if (peer_secid == SECSID_NULL)
> +		err = -EINVAL;
> +	*secid = peer_secid;
>  
> -	return 0;
> +	return err;
>  }
>  
>  static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
> @@ -4407,6 +4403,17 @@ static int selinux_setprocattr(struct ta
>  	return size;
>  }
>  
> +static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
> +{
> +	return security_sid_to_context(secid, secdata, seclen);
> +}
> +
> +static void selinux_release_secctx(char *secdata, u32 seclen)
> +{
> +	if (secdata)
> +		kfree(secdata);
> +}
> +
>  #ifdef CONFIG_KEYS
>  
>  static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
> @@ -4587,6 +4594,9 @@ static struct security_operations selinu
>  	.getprocattr =                  selinux_getprocattr,
>  	.setprocattr =                  selinux_setprocattr,
>  
> +	.secid_to_secctx =		selinux_secid_to_secctx,
> +	.release_secctx =		selinux_release_secctx,
> +
>          .unix_stream_connect =		selinux_socket_unix_stream_connect,
>  	.unix_may_send =		selinux_socket_unix_may_send,
>  
> diff -puN security/dummy.c~af_unix-datagram-getpeersec-ml-fix security/dummy.c
> --- linux-2.6.18-rc2/security/dummy.c~af_unix-datagram-getpeersec-ml-fix	2006-07-24 01:01:07.000000000 -0400
> +++ linux-2.6.18-rc2-cxzhang/security/dummy.c	2006-08-01 23:37:48.000000000 -0400
> @@ -791,8 +791,7 @@ static int dummy_socket_getpeersec_strea
>  	return -ENOPROTOOPT;
>  }
>  
> -static int dummy_socket_getpeersec_dgram(struct sk_buff *skb, char **secdata,
> -					 u32 *seclen)
> +static int dummy_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
>  {
>  	return -ENOPROTOOPT;
>  }
> @@ -876,6 +875,15 @@ static int dummy_setprocattr(struct task
>  	return -EINVAL;
>  }
>  
> +static int dummy_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static void dummy_release_secctx(char *secdata, u32 seclen)
> +{
> +}
> +
>  #ifdef CONFIG_KEYS
>  static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx,
>  				  unsigned long flags)
> @@ -1028,6 +1036,8 @@ void security_fixup_ops (struct security
>  	set_to_dummy_if_null(ops, d_instantiate);
>   	set_to_dummy_if_null(ops, getprocattr);
>   	set_to_dummy_if_null(ops, setprocattr);
> + 	set_to_dummy_if_null(ops, secid_to_secctx);
> + 	set_to_dummy_if_null(ops, release_secctx);
>  #ifdef CONFIG_SECURITY_NETWORK
>  	set_to_dummy_if_null(ops, unix_stream_connect);
>  	set_to_dummy_if_null(ops, unix_may_send);
> diff -puN net/ipv4/ip_sockglue.c~af_unix-datagram-getpeersec-ml-fix net/ipv4/ip_sockglue.c
> --- linux-2.6.18-rc2/net/ipv4/ip_sockglue.c~af_unix-datagram-getpeersec-ml-fix	2006-07-24 18:42:18.000000000 -0400
> +++ linux-2.6.18-rc2-cxzhang/net/ipv4/ip_sockglue.c	2006-08-01 23:09:50.000000000 -0400
> @@ -112,14 +112,19 @@ static void ip_cmsg_recv_retopts(struct 
>  static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>  {
>  	char *secdata;
> -	u32 seclen;
> +	u32 seclen, secid;
>  	int err;
>  
> -	err = security_socket_getpeersec_dgram(skb, &secdata, &seclen);
> +	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
> +	if (err)
> +		return;
> +
> +	err = security_secid_to_secctx(secid, &secdata, &seclen);
>  	if (err)
>  		return;
>  
>  	put_cmsg(msg, SOL_IP, SCM_SECURITY, seclen, secdata);
> +	security_release_secctx(secdata, seclen);
>  }
>  
> 
> _
> -

-- 
Stephen Smalley
National Security Agency

