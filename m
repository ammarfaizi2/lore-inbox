Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbUKZTcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUKZTcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUKZTcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:32:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54790 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262427AbUKZTYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:24:25 -0500
Date: Thu, 25 Nov 2004 18:24:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: sri@us.ibm.com
Cc: lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [2.6 patch] SCTP: possible cleanups
Message-ID: <20041125172412.GG3537@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups for the SCTP 
code:
- remove unused code
- make needlessly global code static

This patch is not intended for being blindly applies, please review and 
check whether part of it might conflict with pending patches.


diffstat output:
 include/net/sctp/command.h   |   13 -----
 include/net/sctp/constants.h |    4 -
 include/net/sctp/sctp.h      |   10 ----
 include/net/sctp/sm.h        |   61 --------------------------
 include/net/sctp/structs.h   |   22 ---------
 include/net/sctp/tsnmap.h    |   16 ------
 include/net/sctp/ulpevent.h  |    2 
 include/net/sctp/ulpqueue.h  |    1 
 net/sctp/associola.c         |   72 +++++++++++--------------------
 net/sctp/bind_addr.c         |   17 -------
 net/sctp/chunk.c             |    8 +--
 net/sctp/command.c           |   23 ---------
 net/sctp/debug.c             |   17 -------
 net/sctp/endpointola.c       |   54 +++++++++++------------
 net/sctp/input.c             |   46 ++++++++++---------
 net/sctp/inqueue.c           |   13 -----
 net/sctp/ipv6.c              |   20 ++++----
 net/sctp/objcnt.c            |    2 
 net/sctp/outqueue.c          |   15 ------
 net/sctp/proc.c              |    2 
 net/sctp/protocol.c          |   34 +++++++-------
 net/sctp/sm_make_chunk.c     |   81 ++++++++++-------------------------
 net/sctp/sm_sideeffect.c     |   66 +++++++++++++++++++---------
 net/sctp/sm_statefuns.c      |   81 +++++++++++++++++++++++------------
 net/sctp/sm_statetable.c     |   27 ++++++++---
 net/sctp/socket.c            |    4 -
 net/sctp/ssnmap.c            |    7 ++-
 net/sctp/transport.c         |   56 ++++++++++++------------
 net/sctp/tsnmap.c            |   39 ++--------------
 net/sctp/ulpevent.c          |   18 ++++---
 net/sctp/ulpqueue.c          |   21 ---------
 31 files changed, 306 insertions(+), 546 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/include/net/sctp/structs.h.old	2004-11-25 00:33:15.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/net/sctp/structs.h	2004-11-25 03:29:32.000000000 +0100
@@ -406,7 +406,6 @@
 	int malloced;
 };
 
-struct sctp_ssnmap *sctp_ssnmap_init(struct sctp_ssnmap *, __u16, __u16);
 struct sctp_ssnmap *sctp_ssnmap_new(__u16 in, __u16 out, int gfp);
 void sctp_ssnmap_free(struct sctp_ssnmap *map);
 void sctp_ssnmap_clear(struct sctp_ssnmap *map);
@@ -538,12 +537,9 @@
 struct sctp_datamsg *sctp_datamsg_from_user(struct sctp_association *,
 					    struct sctp_sndrcvinfo *,
 					    struct msghdr *, int len);
-struct sctp_datamsg *sctp_datamsg_new(int gfp);
 void sctp_datamsg_put(struct sctp_datamsg *);
-void sctp_datamsg_hold(struct sctp_datamsg *);
 void sctp_datamsg_free(struct sctp_datamsg *);
 void sctp_datamsg_track(struct sctp_chunk *);
-void sctp_datamsg_assign(struct sctp_datamsg *, struct sctp_chunk *);
 void sctp_chunk_fail(struct sctp_chunk *, int error);
 int sctp_chunk_abandoned(struct sctp_chunk *);
 
@@ -651,8 +647,6 @@
 void sctp_chunk_put(struct sctp_chunk *);
 int sctp_user_addto_chunk(struct sctp_chunk *chunk, int off, int len,
 			  struct iovec *data);
-struct sctp_chunk *sctp_make_chunk(const struct sctp_association *, __u8 type,
-				   __u8 flags, int size);
 void sctp_chunk_free(struct sctp_chunk *);
 void  *sctp_addto_chunk(struct sctp_chunk *, int len, const void *data);
 struct sctp_chunk *sctp_chunkify(struct sk_buff *,
@@ -922,15 +916,12 @@
 };
 
 struct sctp_transport *sctp_transport_new(const union sctp_addr *, int);
-struct sctp_transport *sctp_transport_init(struct sctp_transport *,
-					   const union sctp_addr *, int);
 void sctp_transport_set_owner(struct sctp_transport *,
 			      struct sctp_association *);
 void sctp_transport_route(struct sctp_transport *, union sctp_addr *,
 			  struct sctp_opt *);
 void sctp_transport_pmtu(struct sctp_transport *);
 void sctp_transport_free(struct sctp_transport *);
-void sctp_transport_destroy(struct sctp_transport *);
 void sctp_transport_reset_timers(struct sctp_transport *);
 void sctp_transport_hold(struct sctp_transport *);
 void sctp_transport_put(struct sctp_transport *);
@@ -961,7 +952,6 @@
 	int malloced;	     /* Is this structure kfree()able?	*/
 };
 
-struct sctp_inq *sctp_inq_new(void);
 void sctp_inq_init(struct sctp_inq *);
 void sctp_inq_free(struct sctp_inq *);
 void sctp_inq_push(struct sctp_inq *, struct sctp_chunk *packet);
@@ -1029,7 +1019,6 @@
 	char malloced;
 };
 
-struct sctp_outq *sctp_outq_new(struct sctp_association *);
 void sctp_outq_init(struct sctp_association *, struct sctp_outq *);
 void sctp_outq_teardown(struct sctp_outq *);
 void sctp_outq_free(struct sctp_outq*);
@@ -1070,7 +1059,6 @@
 	int malloced;	     /* Are we kfree()able?  */
 };
 
-struct sctp_bind_addr *sctp_bind_addr_new(int gfp_mask);
 void sctp_bind_addr_init(struct sctp_bind_addr *, __u16 port);
 void sctp_bind_addr_free(struct sctp_bind_addr *);
 int sctp_bind_addr_copy(struct sctp_bind_addr *dest,
@@ -1220,8 +1208,6 @@
 
 /* These are function signatures for manipulating endpoints.  */
 struct sctp_endpoint *sctp_endpoint_new(struct sock *, int);
-struct sctp_endpoint *sctp_endpoint_init(struct sctp_endpoint *,
-					 struct sock *, int gfp);
 void sctp_endpoint_free(struct sctp_endpoint *);
 void sctp_endpoint_put(struct sctp_endpoint *);
 void sctp_endpoint_hold(struct sctp_endpoint *);
@@ -1243,8 +1229,6 @@
 int sctp_process_init(struct sctp_association *, sctp_cid_t cid,
 		      const union sctp_addr *peer,
 		      sctp_init_chunk_t *init, int gfp);
-int sctp_process_param(struct sctp_association *, union sctp_params param,
-		       const union sctp_addr *from, int gfp);
 __u32 sctp_generate_tag(const struct sctp_endpoint *);
 __u32 sctp_generate_tsn(const struct sctp_endpoint *);
 
@@ -1690,10 +1674,6 @@
 struct sctp_association *
 sctp_association_new(const struct sctp_endpoint *, const struct sock *,
 		     sctp_scope_t scope, int gfp);
-struct sctp_association *
-sctp_association_init(struct sctp_association *, const struct sctp_endpoint *,
-		      const struct sock *, sctp_scope_t scope,
-		      int gfp);
 void sctp_association_free(struct sctp_association *);
 void sctp_association_put(struct sctp_association *);
 void sctp_association_hold(struct sctp_association *);
@@ -1722,7 +1702,6 @@
 		       struct sctp_association *new);
 
 __u32 sctp_association_get_next_tsn(struct sctp_association *);
-__u32 sctp_association_get_tsn_block(struct sctp_association *, int);
 
 void sctp_assoc_sync_pmtu(struct sctp_association *);
 void sctp_assoc_rwnd_increase(struct sctp_association *, unsigned);
@@ -1736,7 +1715,6 @@
 int sctp_cmp_addr_exact(const union sctp_addr *ss1,
 			const union sctp_addr *ss2);
 struct sctp_chunk *sctp_get_ecne_prepend(struct sctp_association *asoc);
-struct sctp_chunk *sctp_get_no_prepend(struct sctp_association *asoc);
 
 /* A convenience structure to parse out SCTP specific CMSGs. */
 typedef struct sctp_cmsgs {
--- linux-2.6.10-rc2-mm3-full/include/net/sctp/command.h.old	2004-11-25 00:37:53.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/net/sctp/command.h	2004-11-25 00:38:13.000000000 +0100
@@ -189,11 +189,6 @@
 } sctp_cmd_seq_t;
 
 
-/* Create a new sctp_command_sequence.
- * Return NULL if creating a new sequence fails.
- */
-sctp_cmd_seq_t *sctp_new_cmd_seq(int gfp);
-
 /* Initialize a block of memory as a command sequence.
  * Return 0 if the initialization fails.
  */
@@ -207,18 +202,10 @@
  */
 int sctp_add_cmd(sctp_cmd_seq_t *seq, sctp_verb_t verb, sctp_arg_t obj);
 
-/* Rewind an sctp_cmd_seq_t to iterate from the start.
- * Return 0 if the rewind fails.
- */
-int sctp_rewind_sequence(sctp_cmd_seq_t *seq);
-
 /* Return the next command structure in an sctp_cmd_seq.
  * Return NULL at the end of the sequence.
  */
 sctp_cmd_t *sctp_next_cmd(sctp_cmd_seq_t *seq);
 
-/* Dispose of a command sequence.  */
-void sctp_free_cmd_seq(sctp_cmd_seq_t *seq);
-
 #endif /* __net_sctp_command_h__ */
 
--- linux-2.6.10-rc2-mm3-full/include/net/sctp/constants.h.old	2004-11-25 00:39:10.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/net/sctp/constants.h	2004-11-25 00:39:20.000000000 +0100
@@ -155,10 +155,6 @@
 		       		- (unsigned long)(c->chunk_hdr)\
 				- sizeof(sctp_data_chunk_t)))
 
-/* This is a table of printable names of sctp_param_t's.  */
-extern const char *sctp_param_tbl[];
-
-
 #define SCTP_MAX_ERROR_CAUSE  SCTP_ERROR_NONEXIST_IP
 #define SCTP_NUM_ERROR_CAUSE  10
 
--- linux-2.6.10-rc2-mm3-full/include/net/sctp/sctp.h.old	2004-11-25 00:41:46.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/net/sctp/sctp.h	2004-11-25 01:34:35.000000000 +0100
@@ -162,17 +162,9 @@
 int sctp_rcv(struct sk_buff *skb);
 void sctp_v4_err(struct sk_buff *skb, u32 info);
 void sctp_hash_established(struct sctp_association *);
-void __sctp_hash_established(struct sctp_association *);
 void sctp_unhash_established(struct sctp_association *);
-void __sctp_unhash_established(struct sctp_association *);
 void sctp_hash_endpoint(struct sctp_endpoint *);
-void __sctp_hash_endpoint(struct sctp_endpoint *);
 void sctp_unhash_endpoint(struct sctp_endpoint *);
-void __sctp_unhash_endpoint(struct sctp_endpoint *);
-struct sctp_association *__sctp_lookup_association(
-	const union sctp_addr *,
-	const union sctp_addr *,
-	struct sctp_transport **);
 struct sock *sctp_err_lookup(int family, struct sk_buff *,
 			     struct sctphdr *, struct sctp_endpoint **,
 			     struct sctp_association **,
@@ -310,8 +302,6 @@
 
 int sctp_v6_init(void);
 void sctp_v6_exit(void);
-void sctp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
-			int type, int code, int offset, __u32 info);
 
 #else /* #ifdef defined(CONFIG_IPV6) */
 
--- linux-2.6.10-rc2-mm3-full/include/net/sctp/sm.h.old	2004-11-25 01:42:52.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/net/sctp/sm.h	2004-11-25 03:14:05.000000000 +0100
@@ -128,7 +128,6 @@
 sctp_state_fn_t sctp_sf_do_ecn_cwr;
 sctp_state_fn_t sctp_sf_do_ecne;
 sctp_state_fn_t sctp_sf_ootb;
-sctp_state_fn_t sctp_sf_shut_8_4_5;
 sctp_state_fn_t sctp_sf_pdiscard;
 sctp_state_fn_t sctp_sf_violation;
 sctp_state_fn_t sctp_sf_discard_chunk;
@@ -138,7 +137,6 @@
 sctp_state_fn_t sctp_sf_unk_chunk;
 sctp_state_fn_t sctp_sf_do_8_5_1_E_sa;
 sctp_state_fn_t sctp_sf_cookie_echoed_err;
-sctp_state_fn_t sctp_sf_do_5_2_6_stale;
 sctp_state_fn_t sctp_sf_do_asconf;
 sctp_state_fn_t sctp_sf_do_asconf_ack;
 sctp_state_fn_t sctp_sf_do_9_2_reshutack;
@@ -200,19 +198,10 @@
 struct sctp_chunk *sctp_make_cwr(const struct sctp_association *,
 				 const __u32 lowest_tsn,
 				 const struct sctp_chunk *);
-struct sctp_chunk *sctp_make_datafrag(struct sctp_association *,
-				 const struct sctp_sndrcvinfo *sinfo,
-				 int len, const __u8 *data,
-				 __u8 flags, __u16 ssn);
 struct sctp_chunk * sctp_make_datafrag_empty(struct sctp_association *,
 					const struct sctp_sndrcvinfo *sinfo,
 					int len, const __u8 flags,
 					__u16 ssn);
-struct sctp_chunk *sctp_make_data(struct sctp_association *,
-			     const struct sctp_sndrcvinfo *sinfo,
-			     int len, const __u8 *data);
-struct sctp_chunk *sctp_make_data_empty(struct sctp_association *,
-				   const struct sctp_sndrcvinfo *, int len);
 struct sctp_chunk *sctp_make_ecne(const struct sctp_association *,
 				  const __u32);
 struct sctp_chunk *sctp_make_sack(const struct sctp_association *);
@@ -246,17 +235,12 @@
 				 const void *payload,
 				 size_t paylen);
 
-struct sctp_chunk *sctp_make_asconf(struct sctp_association *asoc,
-				    union sctp_addr *addr,
-				    int vparam_len);
 struct sctp_chunk *sctp_make_asconf_update_ip(struct sctp_association *,
 					      union sctp_addr *,
 					      struct sockaddr *,
 					      int, __u16);
 struct sctp_chunk *sctp_make_asconf_set_prim(struct sctp_association *asoc,
 					     union sctp_addr *addr);
-struct sctp_chunk *sctp_make_asconf_ack(const struct sctp_association *asoc,
-					__u32 serial, int vparam_len);
 struct sctp_chunk *sctp_process_asconf(struct sctp_association *asoc,
 				       struct sctp_chunk *asconf);
 int sctp_process_asconf_ack(struct sctp_association *asoc,
@@ -277,71 +261,26 @@
                void *event_arg,
                int gfp);
 
-int sctp_side_effects(sctp_event_t event_type, sctp_subtype_t subtype,
-		      sctp_state_t state,
-                      struct sctp_endpoint *,
-                      struct sctp_association *asoc,
-                      void *event_arg,
-                      sctp_disposition_t status,
-		      sctp_cmd_seq_t *commands,
-                      int gfp);
-
 /* 2nd level prototypes */
-int sctp_cmd_interpreter(sctp_event_t, sctp_subtype_t, sctp_state_t,
-			 struct sctp_endpoint *, struct sctp_association *,
-			 void *event_arg, sctp_disposition_t,
-			 sctp_cmd_seq_t *retval, int gfp);
-
-
-int sctp_gen_sack(struct sctp_association *, int force, sctp_cmd_seq_t *);
 void sctp_generate_t3_rtx_event(unsigned long peer);
 void sctp_generate_heartbeat_event(unsigned long peer);
 
-sctp_sackhdr_t *sctp_sm_pull_sack(struct sctp_chunk *);
-struct sctp_packet *sctp_abort_pkt_new(const struct sctp_endpoint *,
-				       const struct sctp_association *,
-				       struct sctp_chunk *chunk,
-				       const void *payload,
-				       size_t paylen);
-struct sctp_packet *sctp_ootb_pkt_new(const struct sctp_association *,
-				      const struct sctp_chunk *);
 void sctp_ootb_pkt_free(struct sctp_packet *);
 
-struct sctp_cookie_param *
-sctp_pack_cookie(const struct sctp_endpoint *, const struct sctp_association *,
-		 const struct sctp_chunk *, int *cookie_len,
-		 const __u8 *, int addrs_len);
 struct sctp_association *sctp_unpack_cookie(const struct sctp_endpoint *,
 				       const struct sctp_association *,
 				       struct sctp_chunk *, int gfp, int *err,
 				       struct sctp_chunk **err_chk_p);
 int sctp_addip_addr_config(struct sctp_association *, sctp_param_t,
 			   struct sockaddr_storage*, int);
-void sctp_send_stale_cookie_err(const struct sctp_endpoint *ep,
-				const struct sctp_association *asoc,
-				const struct sctp_chunk *chunk,
-				sctp_cmd_seq_t *commands,
-				struct sctp_chunk *err_chunk);
-int sctp_eat_data(const struct sctp_association *asoc,
-		  struct sctp_chunk *chunk,
-		  sctp_cmd_seq_t *commands);
 
 /* 3rd level prototypes */
 __u32 sctp_generate_tag(const struct sctp_endpoint *);
 __u32 sctp_generate_tsn(const struct sctp_endpoint *);
 
 /* Extern declarations for major data structures.  */
-const sctp_sm_table_entry_t *sctp_chunk_event_lookup(sctp_cid_t, sctp_state_t);
-extern const sctp_sm_table_entry_t
-primitive_event_table[SCTP_NUM_PRIMITIVE_TYPES][SCTP_STATE_NUM_STATES];
-extern const sctp_sm_table_entry_t
-other_event_table[SCTP_NUM_OTHER_TYPES][SCTP_STATE_NUM_STATES];
-extern const sctp_sm_table_entry_t
-timeout_event_table[SCTP_NUM_TIMEOUT_TYPES][SCTP_STATE_NUM_STATES];
 extern sctp_timer_event_t *sctp_timer_events[SCTP_NUM_TIMEOUT_TYPES];
 
-/* These are some handy utility macros... */
-
 
 /* Get the size of a DATA chunk payload. */
 static inline __u16 sctp_data_size(struct sctp_chunk *chunk)
--- linux-2.6.10-rc2-mm3-full/net/sctp/associola.c.old	2004-11-25 00:33:40.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/associola.c	2004-11-25 00:34:52.000000000 +0100
@@ -66,33 +66,8 @@
 
 /* 1st Level Abstractions. */
 
-/* Allocate and initialize a new association */
-struct sctp_association *sctp_association_new(const struct sctp_endpoint *ep,
-					 const struct sock *sk,
-					 sctp_scope_t scope, int gfp)
-{
-	struct sctp_association *asoc;
-
-	asoc = t_new(struct sctp_association, gfp);
-	if (!asoc)
-		goto fail;
-
-	if (!sctp_association_init(asoc, ep, sk, scope, gfp))
-		goto fail_init;
-
-	asoc->base.malloced = 1;
-	SCTP_DBG_OBJCNT_INC(assoc);
-
-	return asoc;
-
-fail_init:
-	kfree(asoc);
-fail:
-	return NULL;
-}
-
 /* Initialize a new association from provided memory. */
-struct sctp_association *sctp_association_init(struct sctp_association *asoc,
+static struct sctp_association *sctp_association_init(struct sctp_association *asoc,
 					  const struct sctp_endpoint *ep,
 					  const struct sock *sk,
 					  sctp_scope_t scope,
@@ -296,6 +271,31 @@
 	return NULL;
 }
 
+/* Allocate and initialize a new association */
+struct sctp_association *sctp_association_new(const struct sctp_endpoint *ep,
+					 const struct sock *sk,
+					 sctp_scope_t scope, int gfp)
+{
+	struct sctp_association *asoc;
+
+	asoc = t_new(struct sctp_association, gfp);
+	if (!asoc)
+		goto fail;
+
+	if (!sctp_association_init(asoc, ep, sk, scope, gfp))
+		goto fail_init;
+
+	asoc->base.malloced = 1;
+	SCTP_DBG_OBJCNT_INC(assoc);
+
+	return asoc;
+
+fail_init:
+	kfree(asoc);
+fail:
+	return NULL;
+}
+
 /* Free this association if possible.  There may still be users, so
  * the actual deallocation may be delayed.
  */
@@ -714,18 +714,6 @@
 	return retval;
 }
 
-/* Allocate 'num' TSNs by incrementing the association's TSN by num. */
-__u32 sctp_association_get_tsn_block(struct sctp_association *asoc, int num)
-{
-	__u32 retval = asoc->next_tsn;
-
-	asoc->next_tsn += num;
-	asoc->unack_data += num;
-
-	return retval;
-}
-
-
 /* Compare two addresses to see if they match.  Wildcard addresses
  * only match themselves.
  */
@@ -760,14 +748,6 @@
 	return chunk;
 }
 
-/* Use this function for the packet prepend callback when no ECNE
- * packet is desired (e.g. some packets don't like to be bundled).
- */
-struct sctp_chunk *sctp_get_no_prepend(struct sctp_association *asoc)
-{
-	return NULL;
-}
-
 /*
  * Find which transport this TSN was sent on.
  */
--- linux-2.6.10-rc2-mm3-full/net/sctp/bind_addr.c.old	2004-11-25 00:35:13.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/bind_addr.c	2004-11-25 00:35:23.000000000 +0100
@@ -104,23 +104,6 @@
 	return error;
 }
 
-/* Create a new SCTP_bind_addr from nothing.  */
-struct sctp_bind_addr *sctp_bind_addr_new(int gfp)
-{
-	struct sctp_bind_addr *retval;
-
-	retval = t_new(struct sctp_bind_addr, gfp);
-	if (!retval)
-		goto nomem;
-
-	sctp_bind_addr_init(retval, 0);
-	retval->malloced = 1;
-	SCTP_DBG_OBJCNT_INC(bind_addr);
-
-nomem:
-	return retval;
-}
-
 /* Initialize the SCTP_bind_addr structure for either an endpoint or
  * an association.
  */
--- linux-2.6.10-rc2-mm3-full/net/sctp/chunk.c.old	2004-11-25 00:36:15.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/chunk.c	2004-11-25 00:36:55.000000000 +0100
@@ -51,7 +51,7 @@
  */
 
 /* Initialize datamsg from memory. */
-void sctp_datamsg_init(struct sctp_datamsg *msg)
+static void sctp_datamsg_init(struct sctp_datamsg *msg)
 {
 	atomic_set(&msg->refcnt, 1);
 	msg->send_failed = 0;
@@ -62,7 +62,7 @@
 }
 
 /* Allocate and initialize datamsg. */
-struct sctp_datamsg *sctp_datamsg_new(int gfp)
+static struct sctp_datamsg *sctp_datamsg_new(int gfp)
 {
 	struct sctp_datamsg *msg;
 	msg = kmalloc(sizeof(struct sctp_datamsg), gfp);
@@ -124,7 +124,7 @@
 }
 
 /* Hold a reference. */
-void sctp_datamsg_hold(struct sctp_datamsg *msg)
+static void sctp_datamsg_hold(struct sctp_datamsg *msg)
 {
 	atomic_inc(&msg->refcnt);
 }
@@ -151,7 +151,7 @@
 }
 
 /* Assign a chunk to this datamsg. */
-void sctp_datamsg_assign(struct sctp_datamsg *msg, struct sctp_chunk *chunk)
+static void sctp_datamsg_assign(struct sctp_datamsg *msg, struct sctp_chunk *chunk)
 {
 	sctp_datamsg_hold(msg);
 	chunk->msg = msg;
--- linux-2.6.10-rc2-mm3-full/net/sctp/command.c.old	2004-11-25 00:38:22.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/command.c	2004-11-25 00:38:55.000000000 +0100
@@ -42,17 +42,6 @@
 #include <net/sctp/sctp.h>
 #include <net/sctp/sm.h>
 
-/* Create a new sctp_command_sequence.  */
-sctp_cmd_seq_t *sctp_new_cmd_seq(int gfp)
-{
-	sctp_cmd_seq_t *retval = t_new(sctp_cmd_seq_t, gfp);
-
-	if (retval)
-		sctp_init_cmd_seq(retval);
-
-	return retval;
-}
-
 /* Initialize a block of memory as a command sequence. */
 int sctp_init_cmd_seq(sctp_cmd_seq_t *seq)
 {
@@ -77,13 +66,6 @@
 	return 0;
 }
 
-/* Rewind an sctp_cmd_seq_t to iterate from the start.  */
-int sctp_rewind_sequence(sctp_cmd_seq_t *seq)
-{
-	seq->next_cmd = 0;
-	return 1;		/* We always succeed. */
-}
-
 /* Return the next command structure in a sctp_cmd_seq.
  * Returns NULL at the end of the sequence.
  */
@@ -97,8 +79,3 @@
 	return retval;
 }
 
-/* Dispose of a command sequence.  */
-void sctp_free_cmd_seq(sctp_cmd_seq_t *seq)
-{
-	kfree(seq);
-}
--- linux-2.6.10-rc2-mm3-full/net/sctp/debug.c.old	2004-11-25 00:39:29.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/debug.c	2004-11-25 00:39:39.000000000 +0100
@@ -98,23 +98,6 @@
 	return "unknown chunk";
 }
 
-/* These are printable form of variable-length parameters. */
-const char *sctp_param_tbl[SCTP_PARAM_ECN_CAPABLE + 1] = {
-	"",
-	"PARAM_HEARTBEAT_INFO",
-	"",
-	"",
-	"",
-	"PARAM_IPV4_ADDRESS",
-	"PARAM_IPV6_ADDRESS",
-	"PARAM_STATE_COOKIE",
-	"PARAM_UNRECOGNIZED_PARAMETERS",
-	"PARAM_COOKIE_PRESERVATIVE",
-	"",
-	"PARAM_HOST_NAME_ADDRESS",
-	"PARAM_SUPPORTED_ADDRESS_TYPES",
-};
-
 /* These are printable forms of the states.  */
 const char *sctp_state_tbl[SCTP_STATE_NUM_STATES] = {
 	"STATE_EMPTY",
--- linux-2.6.10-rc2-mm3-full/net/sctp/endpointola.c.old	2004-11-25 00:40:01.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/endpointola.c	2004-11-25 00:41:19.000000000 +0100
@@ -63,34 +63,11 @@
 /* Forward declarations for internal helpers. */
 static void sctp_endpoint_bh_rcv(struct sctp_endpoint *ep);
 
-/* Create a sctp_endpoint with all that boring stuff initialized.
- * Returns NULL if there isn't enough memory.
- */
-struct sctp_endpoint *sctp_endpoint_new(struct sock *sk, int gfp)
-{
-	struct sctp_endpoint *ep;
-
-	/* Build a local endpoint. */
-	ep = t_new(struct sctp_endpoint, gfp);
-	if (!ep)
-		goto fail;
-	if (!sctp_endpoint_init(ep, sk, gfp))
-		goto fail_init;
-	ep->base.malloced = 1;
-	SCTP_DBG_OBJCNT_INC(ep);
-	return ep;
-
-fail_init:
-	kfree(ep);
-fail:
-	return NULL;
-}
-
 /*
  * Initialize the base fields of the endpoint structure.
  */
-struct sctp_endpoint *sctp_endpoint_init(struct sctp_endpoint *ep,
-					 struct sock *sk, int gfp)
+static struct sctp_endpoint *sctp_endpoint_init(struct sctp_endpoint *ep,
+						struct sock *sk, int gfp)
 {
 	struct sctp_opt *sp = sctp_sk(sk);
 	memset(ep, 0, sizeof(struct sctp_endpoint));
@@ -160,6 +137,29 @@
 	return ep;
 }
 
+/* Create a sctp_endpoint with all that boring stuff initialized.
+ * Returns NULL if there isn't enough memory.
+ */
+struct sctp_endpoint *sctp_endpoint_new(struct sock *sk, int gfp)
+{
+	struct sctp_endpoint *ep;
+
+	/* Build a local endpoint. */
+	ep = t_new(struct sctp_endpoint, gfp);
+	if (!ep)
+		goto fail;
+	if (!sctp_endpoint_init(ep, sk, gfp))
+		goto fail_init;
+	ep->base.malloced = 1;
+	SCTP_DBG_OBJCNT_INC(ep);
+	return ep;
+
+fail_init:
+	kfree(ep);
+fail:
+	return NULL;
+}
+
 /* Add an association to an endpoint.  */
 void sctp_endpoint_add_asoc(struct sctp_endpoint *ep,
 			    struct sctp_association *asoc)
@@ -184,7 +184,7 @@
 }
 
 /* Final destructor for endpoint.  */
-void sctp_endpoint_destroy(struct sctp_endpoint *ep)
+static void sctp_endpoint_destroy(struct sctp_endpoint *ep)
 {
 	SCTP_ASSERT(ep->base.dead, "Endpoint is not dead", return);
 
@@ -257,7 +257,7 @@
  * We do a linear search of the associations for this endpoint.
  * We return the matching transport address too.
  */
-struct sctp_association *__sctp_endpoint_lookup_assoc(
+static struct sctp_association *__sctp_endpoint_lookup_assoc(
 	const struct sctp_endpoint *ep,
 	const union sctp_addr *paddr,
 	struct sctp_transport **transport)
--- linux-2.6.10-rc2-mm3-full/net/sctp/input.c.old	2004-11-25 00:42:03.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/input.c	2004-11-25 00:46:22.000000000 +0100
@@ -63,11 +63,15 @@
 
 /* Forward declarations for internal helpers. */
 static int sctp_rcv_ootb(struct sk_buff *);
-struct sctp_association *__sctp_rcv_lookup(struct sk_buff *skb,
+static struct sctp_association *__sctp_rcv_lookup(struct sk_buff *skb,
 				      const union sctp_addr *laddr,
 				      const union sctp_addr *paddr,
 				      struct sctp_transport **transportp);
-struct sctp_endpoint *__sctp_rcv_lookup_endpoint(const union sctp_addr *laddr);
+static struct sctp_endpoint *__sctp_rcv_lookup_endpoint(const union sctp_addr *laddr);
+static struct sctp_association *__sctp_lookup_association(
+					const union sctp_addr *local,
+					const union sctp_addr *peer,
+					struct sctp_transport **pt);
 
 
 /* Calculate the SCTP checksum of an SCTP packet.  */
@@ -522,7 +526,7 @@
 }
 
 /* Insert endpoint into the hash table.  */
-void __sctp_hash_endpoint(struct sctp_endpoint *ep)
+static void __sctp_hash_endpoint(struct sctp_endpoint *ep)
 {
 	struct sctp_ep_common **epp;
 	struct sctp_ep_common *epb;
@@ -552,7 +556,7 @@
 }
 
 /* Remove endpoint from the hash table.  */
-void __sctp_unhash_endpoint(struct sctp_endpoint *ep)
+static void __sctp_unhash_endpoint(struct sctp_endpoint *ep)
 {
 	struct sctp_hashbucket *head;
 	struct sctp_ep_common *epb;
@@ -584,7 +588,7 @@
 }
 
 /* Look up an endpoint. */
-struct sctp_endpoint *__sctp_rcv_lookup_endpoint(const union sctp_addr *laddr)
+static struct sctp_endpoint *__sctp_rcv_lookup_endpoint(const union sctp_addr *laddr)
 {
 	struct sctp_hashbucket *head;
 	struct sctp_ep_common *epb;
@@ -610,16 +614,8 @@
 	return ep;
 }
 
-/* Add an association to the hash. Local BH-safe. */
-void sctp_hash_established(struct sctp_association *asoc)
-{
-	sctp_local_bh_disable();
-	__sctp_hash_established(asoc);
-	sctp_local_bh_enable();
-}
-
 /* Insert association into the hash table.  */
-void __sctp_hash_established(struct sctp_association *asoc)
+static void __sctp_hash_established(struct sctp_association *asoc)
 {
 	struct sctp_ep_common **epp;
 	struct sctp_ep_common *epb;
@@ -642,16 +638,16 @@
 	sctp_write_unlock(&head->lock);
 }
 
-/* Remove association from the hash table.  Local BH-safe. */
-void sctp_unhash_established(struct sctp_association *asoc)
+/* Add an association to the hash. Local BH-safe. */
+void sctp_hash_established(struct sctp_association *asoc)
 {
 	sctp_local_bh_disable();
-	__sctp_unhash_established(asoc);
+	__sctp_hash_established(asoc);
 	sctp_local_bh_enable();
 }
 
 /* Remove association from the hash table.  */
-void __sctp_unhash_established(struct sctp_association *asoc)
+static void __sctp_unhash_established(struct sctp_association *asoc)
 {
 	struct sctp_hashbucket *head;
 	struct sctp_ep_common *epb;
@@ -675,8 +671,16 @@
 	sctp_write_unlock(&head->lock);
 }
 
+/* Remove association from the hash table.  Local BH-safe. */
+void sctp_unhash_established(struct sctp_association *asoc)
+{
+	sctp_local_bh_disable();
+	__sctp_unhash_established(asoc);
+	sctp_local_bh_enable();
+}
+
 /* Look up an association. */
-struct sctp_association *__sctp_lookup_association(
+static struct sctp_association *__sctp_lookup_association(
 					const union sctp_addr *local,
 					const union sctp_addr *peer,
 					struct sctp_transport **pt)
@@ -713,7 +717,7 @@
 }
 
 /* Look up an association. BH-safe. */
-struct sctp_association *sctp_lookup_association(const union sctp_addr *laddr,
+static struct sctp_association *sctp_lookup_association(const union sctp_addr *laddr,
 					    const union sctp_addr *paddr,
 					    struct sctp_transport **transportp)
 {
@@ -821,7 +825,7 @@
 }
 
 /* Lookup an association for an inbound skb. */
-struct sctp_association *__sctp_rcv_lookup(struct sk_buff *skb,
+static struct sctp_association *__sctp_rcv_lookup(struct sk_buff *skb,
 				      const union sctp_addr *paddr,
 				      const union sctp_addr *laddr,
 				      struct sctp_transport **transportp)
--- linux-2.6.10-rc2-mm3-full/net/sctp/ipv6.c.old	2004-11-25 01:34:44.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/ipv6.c	2004-11-25 01:35:57.000000000 +0100
@@ -84,8 +84,8 @@
 };
 
 /* ICMP error handler. */
-void sctp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
-		 int type, int code, int offset, __u32 info)
+static void sctp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
+			int type, int code, int offset, __u32 info)
 {
 	struct inet6_dev *idev;
 	struct ipv6hdr *iph = (struct ipv6hdr *)skb->data;
@@ -188,9 +188,9 @@
 /* Returns the dst cache entry for the given source and destination ip
  * addresses.
  */
-struct dst_entry *sctp_v6_get_dst(struct sctp_association *asoc,
-				  union sctp_addr *daddr,
-				  union sctp_addr *saddr)
+static struct dst_entry *sctp_v6_get_dst(struct sctp_association *asoc,
+					 union sctp_addr *daddr,
+					 union sctp_addr *saddr)
 {
 	struct dst_entry *dst;
 	struct flowi fl;
@@ -251,8 +251,10 @@
 /* Fills in the source address(saddr) based on the destination address(daddr)
  * and asoc's bind address list.
  */
-void sctp_v6_get_saddr(struct sctp_association *asoc, struct dst_entry *dst,
-		       union sctp_addr *daddr, union sctp_addr *saddr)
+static void sctp_v6_get_saddr(struct sctp_association *asoc,
+			      struct dst_entry *dst,
+			      union sctp_addr *daddr,
+			      union sctp_addr *saddr)
 {
 	struct sctp_bind_addr *bp;
 	rwlock_t *addr_lock;
@@ -577,8 +579,8 @@
 }
 
 /* Create and initialize a new sk for the socket to be returned by accept(). */
-struct sock *sctp_v6_create_accept_sk(struct sock *sk,
-				      struct sctp_association *asoc)
+static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
+					     struct sctp_association *asoc)
 {
 	struct inet_opt *inet = inet_sk(sk);
 	struct sock *newsk;
--- linux-2.6.10-rc2-mm3-full/net/sctp/inqueue.c.old	2004-11-25 00:46:50.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/inqueue.c	2004-11-25 00:46:57.000000000 +0100
@@ -59,19 +59,6 @@
 	queue->malloced = 0;
 }
 
-/* Create an initialized sctp_inq.  */
-struct sctp_inq *sctp_inq_new(void)
-{
-	struct sctp_inq *retval;
-
-	retval = t_new(struct sctp_inq, GFP_ATOMIC);
-	if (retval) {
-		sctp_inq_init(retval);
-		retval->malloced = 1;
-	}
-        return retval;
-}
-
 /* Release the memory associated with an SCTP inqueue.  */
 void sctp_inq_free(struct sctp_inq *queue)
 {
--- linux-2.6.10-rc2-mm3-full/net/sctp/objcnt.c.old	2004-11-25 01:36:46.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/objcnt.c	2004-11-25 01:36:56.000000000 +0100
@@ -62,7 +62,7 @@
 /* An array to make it easy to pretty print the debug information
  * to the proc fs.
  */
-sctp_dbg_objcnt_entry_t sctp_dbg_objcnt[] = {
+static sctp_dbg_objcnt_entry_t sctp_dbg_objcnt[] = {
 	SCTP_DBG_OBJCNT_ENTRY(sock),
 	SCTP_DBG_OBJCNT_ENTRY(ep),
 	SCTP_DBG_OBJCNT_ENTRY(assoc),
--- linux-2.6.10-rc2-mm3-full/net/sctp/outqueue.c.old	2004-11-25 01:37:31.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/outqueue.c	2004-11-25 01:37:47.000000000 +0100
@@ -190,19 +190,6 @@
 	return 0;
 }
 
-/* Generate a new outqueue.  */
-struct sctp_outq *sctp_outq_new(struct sctp_association *asoc)
-{
-	struct sctp_outq *q;
-
-	q = t_new(struct sctp_outq, GFP_KERNEL);
-	if (q) {
-		sctp_outq_init(asoc, q);
-		q->malloced = 1;
-	}
-	return q;
-}
-
 /* Initialize an existing sctp_outq.  This does the boring stuff.
  * You still need to define handlers if you really want to DO
  * something with this structure...
@@ -362,7 +349,7 @@
 /* Insert a chunk into the sorted list based on the TSNs.  The retransmit list
  * and the abandoned list are in ascending order.
  */
-void sctp_insert_list(struct list_head *head, struct list_head *new)
+static void sctp_insert_list(struct list_head *head, struct list_head *new)
 {
 	struct list_head *pos;
 	struct sctp_chunk *nchunk, *lchunk;
--- linux-2.6.10-rc2-mm3-full/net/sctp/proc.c.old	2004-11-25 01:38:01.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/proc.c	2004-11-25 01:38:10.000000000 +0100
@@ -39,7 +39,7 @@
 #include <linux/init.h>
 #include <net/sctp/sctp.h>
 
-struct snmp_mib sctp_snmp_list[] = {
+static struct snmp_mib sctp_snmp_list[] = {
 	SNMP_MIB_ITEM("SctpCurrEstab", SCTP_MIB_CURRESTAB),
 	SNMP_MIB_ITEM("SctpActiveEstabs", SCTP_MIB_ACTIVEESTABS),
 	SNMP_MIB_ITEM("SctpPassiveEstabs", SCTP_MIB_PASSIVEESTABS),
--- linux-2.6.10-rc2-mm3-full/net/sctp/protocol.c.old	2004-11-25 01:39:00.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/protocol.c	2004-11-25 01:41:45.000000000 +0100
@@ -95,7 +95,7 @@
 }
 
 /* Set up the proc fs entry for the SCTP protocol. */
-__init int sctp_proc_init(void)
+static __init int sctp_proc_init(void)
 {
 	if (!proc_net_sctp) {
 		struct proc_dir_entry *ent;
@@ -124,7 +124,7 @@
  * Note: Do not make this __exit as it is used in the init error
  * path.
  */
-void sctp_proc_exit(void)
+static void sctp_proc_exit(void)
 {
 	sctp_snmp_proc_exit();
 	sctp_eps_proc_exit();
@@ -428,9 +428,9 @@
  * addresses. If an association is passed, trys to get a dst entry with a
  * source address that matches an address in the bind address list.
  */
-struct dst_entry *sctp_v4_get_dst(struct sctp_association *asoc,
-				  union sctp_addr *daddr,
-				  union sctp_addr *saddr)
+static struct dst_entry *sctp_v4_get_dst(struct sctp_association *asoc,
+					 union sctp_addr *daddr,
+					 union sctp_addr *saddr)
 {
 	struct rtable *rt;
 	struct flowi fl;
@@ -520,10 +520,10 @@
 /* For v4, the source address is cached in the route entry(dst). So no need
  * to cache it separately and hence this is an empty routine.
  */
-void sctp_v4_get_saddr(struct sctp_association *asoc,
-		       struct dst_entry *dst,
-		       union sctp_addr *daddr,
-		       union sctp_addr *saddr)
+static void sctp_v4_get_saddr(struct sctp_association *asoc,
+			      struct dst_entry *dst,
+			      union sctp_addr *daddr,
+			      union sctp_addr *saddr)
 {
 	struct rtable *rt = (struct rtable *)dst;
 
@@ -547,8 +547,8 @@
 }
 
 /* Create and initialize a new sk for the socket returned by accept(). */
-struct sock *sctp_v4_create_accept_sk(struct sock *sk,
-				      struct sctp_association *asoc)
+static struct sock *sctp_v4_create_accept_sk(struct sock *sk,
+					     struct sctp_association *asoc)
 {
 	struct sock *newsk;
 	struct inet_opt *inet = inet_sk(sk);
@@ -639,7 +639,7 @@
  * Initialize the control inode/socket with a control endpoint data
  * structure.  This endpoint is reserved exclusively for the OOTB processing.
  */
-int sctp_ctl_sock_init(void)
+static int sctp_ctl_sock_init(void)
 {
 	int err;
 	sa_family_t family;
@@ -808,7 +808,7 @@
 	return ip_queue_xmit(skb, ipfragok);
 }
 
-struct sctp_af sctp_ipv4_specific;
+static struct sctp_af sctp_ipv4_specific;
 
 static struct sctp_pf sctp_pf_inet = {
 	.event_msgname = sctp_inet_event_msgname,
@@ -829,7 +829,7 @@
 };
 
 /* Socket operations.  */
-struct proto_ops inet_seqpacket_ops = {
+static struct proto_ops inet_seqpacket_ops = {
 	.family      = PF_INET,
 	.owner       = THIS_MODULE,
 	.release     = inet_release,       /* Needs to be wrapped... */
@@ -878,7 +878,7 @@
 };
 
 /* IPv4 address related functions.  */
-struct sctp_af sctp_ipv4_specific = {
+static struct sctp_af sctp_ipv4_specific = {
 	.sctp_xmit      = sctp_v4_xmit,
 	.setsockopt     = ip_setsockopt,
 	.getsockopt     = ip_getsockopt,
@@ -959,7 +959,7 @@
 }
 
 /* Initialize the universe into something sensible.  */
-__init int sctp_init(void)
+static __init int sctp_init(void)
 {
 	int i;
 	int status = -EINVAL;
@@ -1196,7 +1196,7 @@
 }
 
 /* Exit handler for the SCTP protocol.  */
-__exit void sctp_exit(void)
+static __exit void sctp_exit(void)
 {
 	/* BUG.  This should probably do something useful like clean
 	 * up all the remaining associations and all that memory.
--- linux-2.6.10-rc2-mm3-full/net/sctp/sm_make_chunk.c.old	2004-11-25 01:43:40.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/sm_make_chunk.c	2004-11-25 01:51:15.000000000 +0100
@@ -67,6 +67,18 @@
 
 extern kmem_cache_t *sctp_chunk_cachep;
 
+static struct sctp_chunk *sctp_make_chunk(const struct sctp_association *asoc,
+					  __u8 type, __u8 flags, int paylen);
+static sctp_cookie_param_t *sctp_pack_cookie(const struct sctp_endpoint *ep,
+					const struct sctp_association *asoc,
+					const struct sctp_chunk *init_chunk,
+					int *cookie_len,
+					const __u8 *raw_addrs, int addrs_len);
+static int sctp_process_param(struct sctp_association *asoc,
+			      union sctp_params param,
+			      const union sctp_addr *peer_addr,
+			      int gfp);
+
 /* What was the inbound interface for this chunk? */
 int sctp_chunk_iif(const struct sctp_chunk *chunk)
 {
@@ -559,52 +571,6 @@
 	return retval;
 }
 
-/* Make a DATA chunk for the given association.  Populate the data
- * payload.
- */
-struct sctp_chunk *sctp_make_datafrag(struct sctp_association *asoc,
-				 const struct sctp_sndrcvinfo *sinfo,
-				 int data_len, const __u8 *data,
-				 __u8 flags, __u16 ssn)
-{
-	struct sctp_chunk *retval;
-
-	retval = sctp_make_datafrag_empty(asoc, sinfo, data_len, flags, ssn);
-	if (retval)
-		sctp_addto_chunk(retval, data_len, data);
-
-	return retval;
-}
-
-/* Make a DATA chunk for the given association to ride on stream id
- * 'stream', with a payload id of 'payload', and a body of 'data'.
- */
-struct sctp_chunk *sctp_make_data(struct sctp_association *asoc,
-			     const struct sctp_sndrcvinfo *sinfo,
-			     int data_len, const __u8 *data)
-{
-	struct sctp_chunk *retval = NULL;
-
-	retval = sctp_make_data_empty(asoc, sinfo, data_len);
-	if (retval)
-		sctp_addto_chunk(retval, data_len, data);
-        return retval;
-}
-
-/* Make a DATA chunk for the given association to ride on stream id
- * 'stream', with a payload id of 'payload', and a body big enough to
- * hold 'data_len' octets of data.  We use this version when we need
- * to build the message AFTER allocating memory.
- */
-struct sctp_chunk *sctp_make_data_empty(struct sctp_association *asoc,
-				   const struct sctp_sndrcvinfo *sinfo,
-				   int data_len)
-{
-	__u8 flags = SCTP_DATA_NOT_FRAG;
-
-	return sctp_make_datafrag_empty(asoc, sinfo, data_len, flags, 0);
-}
-
 /* Create a selective ackowledgement (SACK) for the given
  * association.  This reports on which TSN's we've seen to date,
  * including duplicates and gaps.
@@ -933,7 +899,7 @@
 /* Create an Operation Error chunk with the specified space reserved.
  * This routine can be used for containing multiple causes in the chunk.
  */
-struct sctp_chunk *sctp_make_op_error_space(
+static struct sctp_chunk *sctp_make_op_error_space(
 	const struct sctp_association *asoc,
 	const struct sctp_chunk *chunk,
 	size_t size)
@@ -1062,8 +1028,8 @@
 /* Create a new chunk, setting the type and flags headers from the
  * arguments, reserving enough space for a 'paylen' byte payload.
  */
-struct sctp_chunk *sctp_make_chunk(const struct sctp_association *asoc,
-				   __u8 type, __u8 flags, int paylen)
+static struct sctp_chunk *sctp_make_chunk(const struct sctp_association *asoc,
+					  __u8 type, __u8 flags, int paylen)
 {
 	struct sctp_chunk *retval;
 	sctp_chunkhdr_t *chunk_hdr;
@@ -1261,7 +1227,7 @@
 /* Build a cookie representing asoc.
  * This INCLUDES the param header needed to put the cookie in the INIT ACK.
  */
-sctp_cookie_param_t *sctp_pack_cookie(const struct sctp_endpoint *ep,
+static sctp_cookie_param_t *sctp_pack_cookie(const struct sctp_endpoint *ep,
 				      const struct sctp_association *asoc,
 				      const struct sctp_chunk *init_chunk,
 				      int *cookie_len,
@@ -1912,8 +1878,10 @@
  * work we do.  In particular, we should not build transport
  * structures for the addresses.
  */
-int sctp_process_param(struct sctp_association *asoc, union sctp_params param,
-		       const union sctp_addr *peer_addr, int gfp)
+static int sctp_process_param(struct sctp_association *asoc,
+			      union sctp_params param,
+			      const union sctp_addr *peer_addr,
+			      int gfp)
 {
 	union sctp_addr addr;
 	int i;
@@ -2078,8 +2046,9 @@
  *
  * Address Parameter and other parameter will not be wrapped in this function 
  */
-struct sctp_chunk *sctp_make_asconf(struct sctp_association *asoc,
-				    union sctp_addr *addr, int vparam_len)
+static struct sctp_chunk *sctp_make_asconf(struct sctp_association *asoc,
+					   union sctp_addr *addr,
+					   int vparam_len)
 {
 	sctp_addiphdr_t asconf;
 	struct sctp_chunk *retval;
@@ -2248,8 +2217,8 @@
  *
  * Create an ASCONF_ACK chunk with enough space for the parameter responses. 
  */
-struct sctp_chunk *sctp_make_asconf_ack(const struct sctp_association *asoc,
-					__u32 serial, int vparam_len)
+static struct sctp_chunk *sctp_make_asconf_ack(const struct sctp_association *asoc,
+					       __u32 serial, int vparam_len)
 {
 	sctp_addiphdr_t		asconf;
 	struct sctp_chunk	*retval;
--- linux-2.6.10-rc2-mm3-full/net/sctp/sm_sideeffect.c.old	2004-11-25 01:52:16.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/sm_sideeffect.c	2004-11-25 03:24:28.000000000 +0100
@@ -55,6 +55,24 @@
 #include <net/sctp/sctp.h>
 #include <net/sctp/sm.h>
 
+static int sctp_cmd_interpreter(sctp_event_t event_type,
+				sctp_subtype_t subtype,
+				sctp_state_t state,
+				struct sctp_endpoint *ep,
+				struct sctp_association *asoc,
+				void *event_arg,
+			 	sctp_disposition_t status,
+				sctp_cmd_seq_t *commands,
+				int gfp);
+static int sctp_side_effects(sctp_event_t event_type, sctp_subtype_t subtype,
+			     sctp_state_t state,
+			     struct sctp_endpoint *ep,
+			     struct sctp_association *asoc,
+			     void *event_arg,
+			     sctp_disposition_t status,
+			     sctp_cmd_seq_t *commands,
+			     int gfp);
+
 /********************************************************************
  * Helper functions
  ********************************************************************/
@@ -134,8 +152,8 @@
 }
 
 /* Generate SACK if necessary.  We call this at the end of a packet.  */
-int sctp_gen_sack(struct sctp_association *asoc, int force,
-		  sctp_cmd_seq_t *commands)
+static int sctp_gen_sack(struct sctp_association *asoc, int force,
+			 sctp_cmd_seq_t *commands)
 {
 	__u32 ctsn, max_tsn_seen;
 	struct sctp_chunk *sack;
@@ -276,31 +294,31 @@
 	sctp_association_put(asoc);
 }
 
-void sctp_generate_t1_cookie_event(unsigned long data)
+static void sctp_generate_t1_cookie_event(unsigned long data)
 {
 	struct sctp_association *asoc = (struct sctp_association *) data;
 	sctp_generate_timeout_event(asoc, SCTP_EVENT_TIMEOUT_T1_COOKIE);
 }
 
-void sctp_generate_t1_init_event(unsigned long data)
+static void sctp_generate_t1_init_event(unsigned long data)
 {
 	struct sctp_association *asoc = (struct sctp_association *) data;
 	sctp_generate_timeout_event(asoc, SCTP_EVENT_TIMEOUT_T1_INIT);
 }
 
-void sctp_generate_t2_shutdown_event(unsigned long data)
+static void sctp_generate_t2_shutdown_event(unsigned long data)
 {
 	struct sctp_association *asoc = (struct sctp_association *) data;
 	sctp_generate_timeout_event(asoc, SCTP_EVENT_TIMEOUT_T2_SHUTDOWN);
 }
 
-void sctp_generate_t4_rto_event(unsigned long data)
+static void sctp_generate_t4_rto_event(unsigned long data)
 {
 	struct sctp_association *asoc = (struct sctp_association *) data;
 	sctp_generate_timeout_event(asoc, SCTP_EVENT_TIMEOUT_T4_RTO);
 }
 
-void sctp_generate_t5_shutdown_guard_event(unsigned long data)
+static void sctp_generate_t5_shutdown_guard_event(unsigned long data)
 {
         struct sctp_association *asoc = (struct sctp_association *)data;
         sctp_generate_timeout_event(asoc,
@@ -308,7 +326,7 @@
 
 } /* sctp_generate_t5_shutdown_guard_event() */
 
-void sctp_generate_autoclose_event(unsigned long data)
+static void sctp_generate_autoclose_event(unsigned long data)
 {
 	struct sctp_association *asoc = (struct sctp_association *) data;
 	sctp_generate_timeout_event(asoc, SCTP_EVENT_TIMEOUT_AUTOCLOSE);
@@ -353,7 +371,7 @@
 }
 
 /* Inject a SACK Timeout event into the state machine.  */
-void sctp_generate_sack_event(unsigned long data)
+static void sctp_generate_sack_event(unsigned long data)
 {
 	struct sctp_association *asoc = (struct sctp_association *) data;
 	sctp_generate_timeout_event(asoc, SCTP_EVENT_TIMEOUT_SACK);
@@ -857,14 +875,14 @@
 /*****************************************************************
  * This the master state function side effect processing function.
  *****************************************************************/
-int sctp_side_effects(sctp_event_t event_type, sctp_subtype_t subtype,
-		      sctp_state_t state,
-		      struct sctp_endpoint *ep,
-		      struct sctp_association *asoc,
-		      void *event_arg,
-		      sctp_disposition_t status,
-		      sctp_cmd_seq_t *commands,
-		      int gfp)
+static int sctp_side_effects(sctp_event_t event_type, sctp_subtype_t subtype,
+			     sctp_state_t state,
+			     struct sctp_endpoint *ep,
+			     struct sctp_association *asoc,
+			     void *event_arg,
+			     sctp_disposition_t status,
+			     sctp_cmd_seq_t *commands,
+			     int gfp)
 {
 	int error;
 
@@ -944,11 +962,15 @@
  ********************************************************************/
 
 /* This is the side-effect interpreter.  */
-int sctp_cmd_interpreter(sctp_event_t event_type, sctp_subtype_t subtype,
-			 sctp_state_t state, struct sctp_endpoint *ep,
-			 struct sctp_association *asoc, void *event_arg,
-			 sctp_disposition_t status, sctp_cmd_seq_t *commands,
-			 int gfp)
+static int sctp_cmd_interpreter(sctp_event_t event_type,
+				sctp_subtype_t subtype,
+				sctp_state_t state,
+				struct sctp_endpoint *ep,
+				struct sctp_association *asoc,
+				void *event_arg,
+			 	sctp_disposition_t status,
+				sctp_cmd_seq_t *commands,
+				int gfp)
 {
 	int error = 0;
 	int force;
--- linux-2.6.10-rc2-mm3-full/net/sctp/sm_statefuns.c.old	2004-11-25 01:56:27.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/sm_statefuns.c	2004-11-25 02:14:47.000000000 +0100
@@ -65,6 +65,33 @@
 #include <net/sctp/sm.h>
 #include <net/sctp/structs.h>
 
+static struct sctp_packet *sctp_abort_pkt_new(const struct sctp_endpoint *ep,
+				  const struct sctp_association *asoc,
+				  struct sctp_chunk *chunk,
+				  const void *payload,
+				  size_t paylen);
+static int sctp_eat_data(const struct sctp_association *asoc,
+			 struct sctp_chunk *chunk,
+			 sctp_cmd_seq_t *commands);
+static struct sctp_packet *sctp_ootb_pkt_new(const struct sctp_association *asoc,
+					     const struct sctp_chunk *chunk);
+static void sctp_send_stale_cookie_err(const struct sctp_endpoint *ep,
+				       const struct sctp_association *asoc,
+				       const struct sctp_chunk *chunk,
+				       sctp_cmd_seq_t *commands,
+				       struct sctp_chunk *err_chunk);
+static sctp_disposition_t sctp_sf_do_5_2_6_stale(const struct sctp_endpoint *ep,
+						 const struct sctp_association *asoc,
+						 const sctp_subtype_t type,
+						 void *arg,
+						 sctp_cmd_seq_t *commands);
+static sctp_disposition_t sctp_sf_shut_8_4_5(const struct sctp_endpoint *ep,
+					     const struct sctp_association *asoc,
+					     const sctp_subtype_t type,
+					     void *arg,
+					     sctp_cmd_seq_t *commands);
+static struct sctp_sackhdr *sctp_sm_pull_sack(struct sctp_chunk *chunk);
+
 /**********************************************************
  * These are the state functions for handling chunk events.
  **********************************************************/
@@ -748,11 +775,11 @@
 }
 
 /* Generate and sendout a heartbeat packet.  */
-sctp_disposition_t sctp_sf_heartbeat(const struct sctp_endpoint *ep,
-				     const struct sctp_association *asoc,
-				     const sctp_subtype_t type,
-				     void *arg,
-				     sctp_cmd_seq_t *commands)
+static sctp_disposition_t sctp_sf_heartbeat(const struct sctp_endpoint *ep,
+					    const struct sctp_association *asoc,
+					    const sctp_subtype_t type,
+					    void *arg,
+					    sctp_cmd_seq_t *commands)
 {
 	struct sctp_transport *transport = (struct sctp_transport *) arg;
 	struct sctp_chunk *reply;
@@ -1928,11 +1955,11 @@
  *
  * The return value is the disposition of the chunk.
  */
-sctp_disposition_t sctp_sf_do_5_2_6_stale(const struct sctp_endpoint *ep,
-					  const struct sctp_association *asoc,
-					  const sctp_subtype_t type,
-					  void *arg,
-					  sctp_cmd_seq_t *commands)
+static sctp_disposition_t sctp_sf_do_5_2_6_stale(const struct sctp_endpoint *ep,
+						 const struct sctp_association *asoc,
+						 const sctp_subtype_t type,
+						 void *arg,
+						 sctp_cmd_seq_t *commands)
 {
 	struct sctp_chunk *chunk = arg;
 	time_t stale;
@@ -2853,11 +2880,11 @@
  *
  * The return value is the disposition of the chunk.
  */
-sctp_disposition_t sctp_sf_shut_8_4_5(const struct sctp_endpoint *ep,
-				      const struct sctp_association *asoc,
-				      const sctp_subtype_t type,
-				      void *arg,
-				      sctp_cmd_seq_t *commands)
+static sctp_disposition_t sctp_sf_shut_8_4_5(const struct sctp_endpoint *ep,
+					     const struct sctp_association *asoc,
+					     const sctp_subtype_t type,
+					     void *arg,
+					     sctp_cmd_seq_t *commands)
 {
 	struct sctp_packet *packet = NULL;
 	struct sctp_chunk *chunk = arg;
@@ -4537,7 +4564,7 @@
  ********************************************************************/
 
 /* Pull the SACK chunk based on the SACK header. */
-struct sctp_sackhdr *sctp_sm_pull_sack(struct sctp_chunk *chunk)
+static struct sctp_sackhdr *sctp_sm_pull_sack(struct sctp_chunk *chunk)
 {
 	struct sctp_sackhdr *sack;
 	unsigned int len;
@@ -4564,7 +4591,7 @@
 /* Create an ABORT packet to be sent as a response, with the specified
  * error causes.
  */
-struct sctp_packet *sctp_abort_pkt_new(const struct sctp_endpoint *ep,
+static struct sctp_packet *sctp_abort_pkt_new(const struct sctp_endpoint *ep,
 				  const struct sctp_association *asoc,
 				  struct sctp_chunk *chunk,
 				  const void *payload,
@@ -4600,8 +4627,8 @@
 }
 
 /* Allocate a packet for responding in the OOTB conditions.  */
-struct sctp_packet *sctp_ootb_pkt_new(const struct sctp_association *asoc,
-				 const struct sctp_chunk *chunk)
+static struct sctp_packet *sctp_ootb_pkt_new(const struct sctp_association *asoc,
+					     const struct sctp_chunk *chunk)
 {
 	struct sctp_packet *packet;
 	struct sctp_transport *transport;
@@ -4664,11 +4691,11 @@
 }
 
 /* Send a stale cookie error when a invalid COOKIE ECHO chunk is found  */
-void sctp_send_stale_cookie_err(const struct sctp_endpoint *ep,
-				const struct sctp_association *asoc,
-				const struct sctp_chunk *chunk,
-				sctp_cmd_seq_t *commands,
-				struct sctp_chunk *err_chunk)
+static void sctp_send_stale_cookie_err(const struct sctp_endpoint *ep,
+				       const struct sctp_association *asoc,
+				       const struct sctp_chunk *chunk,
+				       sctp_cmd_seq_t *commands,
+				       struct sctp_chunk *err_chunk)
 {
 	struct sctp_packet *packet;
 
@@ -4694,9 +4721,9 @@
 
 
 /* Process a data chunk */
-int sctp_eat_data(const struct sctp_association *asoc,
-		  struct sctp_chunk *chunk,
-		  sctp_cmd_seq_t *commands)
+static int sctp_eat_data(const struct sctp_association *asoc,
+			 struct sctp_chunk *chunk,
+			 sctp_cmd_seq_t *commands)
 {
 	sctp_datahdr_t *data_hdr;
 	struct sctp_chunk *err;
--- linux-2.6.10-rc2-mm3-full/net/sctp/sm_statetable.c.old	2004-11-25 02:15:50.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/sm_statetable.c	2004-11-25 03:23:43.000000000 +0100
@@ -50,6 +50,17 @@
 #include <net/sctp/sctp.h>
 #include <net/sctp/sm.h>
 
+static const sctp_sm_table_entry_t
+primitive_event_table[SCTP_NUM_PRIMITIVE_TYPES][SCTP_STATE_NUM_STATES];
+static const sctp_sm_table_entry_t
+other_event_table[SCTP_NUM_OTHER_TYPES][SCTP_STATE_NUM_STATES];
+static const sctp_sm_table_entry_t
+timeout_event_table[SCTP_NUM_TIMEOUT_TYPES][SCTP_STATE_NUM_STATES];
+
+static const sctp_sm_table_entry_t *sctp_chunk_event_lookup(sctp_cid_t cid,
+							    sctp_state_t state);
+
+
 static const sctp_sm_table_entry_t bug = {
 	.fn = sctp_sf_bug,
 	.name = "sctp_sf_bug"
@@ -419,7 +430,7 @@
  *
  * For base protocol (RFC 2960).
  */
-const sctp_sm_table_entry_t chunk_event_table[SCTP_NUM_BASE_CHUNK_TYPES][SCTP_STATE_NUM_STATES] = {
+static const sctp_sm_table_entry_t chunk_event_table[SCTP_NUM_BASE_CHUNK_TYPES][SCTP_STATE_NUM_STATES] = {
 	TYPE_SCTP_DATA,
 	TYPE_SCTP_INIT,
 	TYPE_SCTP_INIT_ACK,
@@ -482,7 +493,7 @@
 /* The primary index for this table is the chunk type.
  * The secondary index for this table is the state.
  */
-const sctp_sm_table_entry_t addip_chunk_event_table[SCTP_NUM_ADDIP_CHUNK_TYPES][SCTP_STATE_NUM_STATES] = {
+static const sctp_sm_table_entry_t addip_chunk_event_table[SCTP_NUM_ADDIP_CHUNK_TYPES][SCTP_STATE_NUM_STATES] = {
 	TYPE_SCTP_ASCONF,
 	TYPE_SCTP_ASCONF_ACK,
 }; /*state_fn_t addip_chunk_event_table[][] */
@@ -511,7 +522,7 @@
 /* The primary index for this table is the chunk type.
  * The secondary index for this table is the state.
  */
-const sctp_sm_table_entry_t prsctp_chunk_event_table[SCTP_NUM_PRSCTP_CHUNK_TYPES][SCTP_STATE_NUM_STATES] = {
+static const sctp_sm_table_entry_t prsctp_chunk_event_table[SCTP_NUM_PRSCTP_CHUNK_TYPES][SCTP_STATE_NUM_STATES] = {
 	TYPE_SCTP_FWD_TSN,
 }; /*state_fn_t prsctp_chunk_event_table[][] */
 
@@ -684,7 +695,7 @@
 /* The primary index for this table is the primitive type.
  * The secondary index for this table is the state.
  */
-const sctp_sm_table_entry_t primitive_event_table[SCTP_NUM_PRIMITIVE_TYPES][SCTP_STATE_NUM_STATES] = {
+static const sctp_sm_table_entry_t primitive_event_table[SCTP_NUM_PRIMITIVE_TYPES][SCTP_STATE_NUM_STATES] = {
 	TYPE_SCTP_PRIMITIVE_ASSOCIATE,
 	TYPE_SCTP_PRIMITIVE_SHUTDOWN,
 	TYPE_SCTP_PRIMITIVE_ABORT,
@@ -716,7 +727,7 @@
 	{.fn = sctp_sf_ignore_other, .name = "sctp_sf_ignore_other"}, \
 }
 
-const sctp_sm_table_entry_t other_event_table[SCTP_NUM_OTHER_TYPES][SCTP_STATE_NUM_STATES] = {
+static const sctp_sm_table_entry_t other_event_table[SCTP_NUM_OTHER_TYPES][SCTP_STATE_NUM_STATES] = {
 	TYPE_SCTP_OTHER_NO_PENDING_TSN,
 };
 
@@ -931,7 +942,7 @@
 	{.fn = sctp_sf_timer_ignore, .name = "sctp_sf_timer_ignore"}, \
 }
 
-const sctp_sm_table_entry_t timeout_event_table[SCTP_NUM_TIMEOUT_TYPES][SCTP_STATE_NUM_STATES] = {
+static const sctp_sm_table_entry_t timeout_event_table[SCTP_NUM_TIMEOUT_TYPES][SCTP_STATE_NUM_STATES] = {
 	TYPE_SCTP_EVENT_TIMEOUT_NONE,
 	TYPE_SCTP_EVENT_TIMEOUT_T1_COOKIE,
 	TYPE_SCTP_EVENT_TIMEOUT_T1_INIT,
@@ -944,8 +955,8 @@
 	TYPE_SCTP_EVENT_TIMEOUT_AUTOCLOSE,
 };
 
-const sctp_sm_table_entry_t *sctp_chunk_event_lookup(sctp_cid_t cid, 
-						     sctp_state_t state)
+static const sctp_sm_table_entry_t *sctp_chunk_event_lookup(sctp_cid_t cid, 
+							    sctp_state_t state)
 {
 	if (state > SCTP_STATE_MAX)
 		return &bug;
--- linux-2.6.10-rc2-mm3-full/net/sctp/socket.c.old	2004-11-25 02:19:43.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/socket.c	2004-11-25 02:20:25.000000000 +0100
@@ -208,7 +208,7 @@
  * id are specified, the associations matching the address and the id should be
  * the same.
  */
-struct sctp_transport *sctp_addr_id2transport(struct sock *sk,
+static struct sctp_transport *sctp_addr_id2transport(struct sock *sk,
 					      struct sockaddr_storage *addr,
 					      sctp_assoc_t id)
 {
@@ -245,7 +245,7 @@
  *             sockaddr_in6 [RFC 2553]),
  *   addr_len - the size of the address structure.
  */
-int sctp_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
+static int sctp_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
 	int retval = 0;
 
--- linux-2.6.10-rc2-mm3-full/net/sctp/ssnmap.c.old	2004-11-25 02:20:54.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/ssnmap.c	2004-11-25 03:29:59.000000000 +0100
@@ -42,6 +42,9 @@
 
 #define MAX_KMALLOC_SIZE	131072
 
+static struct sctp_ssnmap *sctp_ssnmap_init(struct sctp_ssnmap *map, __u16 in,
+					    __u16 out);
+
 /* Storage size needed for map includes 2 headers and then the
  * specific needs of in or out streams.
  */
@@ -87,8 +90,8 @@
 
 
 /* Initialize a block of memory as a ssnmap.  */
-struct sctp_ssnmap *sctp_ssnmap_init(struct sctp_ssnmap *map, __u16 in,
-				     __u16 out)
+static struct sctp_ssnmap *sctp_ssnmap_init(struct sctp_ssnmap *map, __u16 in,
+					    __u16 out)
 {
 	memset(map, 0x00, sctp_ssnmap_size(in, out));
 
--- linux-2.6.10-rc2-mm3-full/net/sctp/transport.c.old	2004-11-25 02:22:16.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/transport.c	2004-11-25 02:23:01.000000000 +0100
@@ -54,34 +54,10 @@
 
 /* 1st Level Abstractions.  */
 
-/* Allocate and initialize a new transport.  */
-struct sctp_transport *sctp_transport_new(const union sctp_addr *addr, int gfp)
-{
-        struct sctp_transport *transport;
-
-        transport = t_new(struct sctp_transport, gfp);
-	if (!transport)
-		goto fail;
-
-	if (!sctp_transport_init(transport, addr, gfp))
-		goto fail_init;
-
-	transport->malloced = 1;
-	SCTP_DBG_OBJCNT_INC(transport);
-
-	return transport;
-
-fail_init:
-	kfree(transport);
-
-fail:
-	return NULL;
-}
-
 /* Initialize a new transport from provided memory.  */
-struct sctp_transport *sctp_transport_init(struct sctp_transport *peer,
-					   const union sctp_addr *addr,
-					   int gfp)
+static struct sctp_transport *sctp_transport_init(struct sctp_transport *peer,
+						  const union sctp_addr *addr,
+						  int gfp)
 {
 	/* Copy in the address.  */
 	peer->ipaddr = *addr;
@@ -144,6 +120,30 @@
 	return peer;
 }
 
+/* Allocate and initialize a new transport.  */
+struct sctp_transport *sctp_transport_new(const union sctp_addr *addr, int gfp)
+{
+        struct sctp_transport *transport;
+
+        transport = t_new(struct sctp_transport, gfp);
+	if (!transport)
+		goto fail;
+
+	if (!sctp_transport_init(transport, addr, gfp))
+		goto fail_init;
+
+	transport->malloced = 1;
+	SCTP_DBG_OBJCNT_INC(transport);
+
+	return transport;
+
+fail_init:
+	kfree(transport);
+
+fail:
+	return NULL;
+}
+
 /* This transport is no longer needed.  Free up if possible, or
  * delay until it last reference count.
  */
@@ -161,7 +161,7 @@
 /* Destroy the transport data structure.
  * Assumes there are no more users of this structure.
  */
-void sctp_transport_destroy(struct sctp_transport *transport)
+static void sctp_transport_destroy(struct sctp_transport *transport)
 {
 	SCTP_ASSERT(transport->dead, "Transport is not dead", return);
 
--- linux-2.6.10-rc2-mm3-full/include/net/sctp/tsnmap.h.old	2004-11-25 02:23:58.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/net/sctp/tsnmap.h	2004-11-25 02:24:21.000000000 +0100
@@ -120,12 +120,6 @@
 	__u32 start;
 };
 
-/* Create a new tsnmap.  */
-struct sctp_tsnmap *sctp_tsnmap_new(__u16 len, __u32 init_tsn, int gfp);
-
-/* Dispose of a tsnmap.  */
-void sctp_tsnmap_free(struct sctp_tsnmap *);
-
 /* This macro assists in creation of external storage for variable length
  * internal buffers.  We double allocate so the overflow map works.
  */
@@ -210,14 +204,4 @@
 /* Is there a gap in the TSN map? */
 int sctp_tsnmap_has_gap(const struct sctp_tsnmap *);
 
-/* Initialize a gap ack block interator from user-provided memory.  */
-void sctp_tsnmap_iter_init(const struct sctp_tsnmap *,
-			   struct sctp_tsnmap_iter *);
-
-/* Get the next gap ack blocks.  We return 0 if there are no more
- * gap ack blocks.
- */
-int sctp_tsnmap_next_gap_ack(const struct sctp_tsnmap *,
-	struct sctp_tsnmap_iter *,__u16 *start, __u16 *end);
-
 #endif /* __sctp_tsnmap_h__ */
--- linux-2.6.10-rc2-mm3-full/net/sctp/tsnmap.c.old	2004-11-25 02:24:29.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/tsnmap.c	2004-11-25 02:25:39.000000000 +0100
@@ -52,29 +52,6 @@
 				     int *started, __u16 *start,
 				     int *ended, __u16 *end);
 
-/* Create a new sctp_tsnmap.
- * Allocate room to store at least 'len' contiguous TSNs.
- */
-struct sctp_tsnmap *sctp_tsnmap_new(__u16 len, __u32 initial_tsn, int gfp)
-{
-	struct sctp_tsnmap *retval;
-
-	retval = kmalloc(sizeof(struct sctp_tsnmap) +
-			 sctp_tsnmap_storage_size(len), gfp);
-	if (!retval)
-		goto fail;
-
-	if (!sctp_tsnmap_init(retval, len, initial_tsn))
-		goto fail_map;
-	retval->malloced = 1;
-	return retval;
-
-fail_map:
-	kfree(retval);
-fail:
-	return NULL;
-}
-
 /* Initialize a block of memory as a tsnmap.  */
 struct sctp_tsnmap *sctp_tsnmap_init(struct sctp_tsnmap *map, __u16 len,
 				     __u32 initial_tsn)
@@ -168,16 +145,9 @@
 }
 
 
-/* Dispose of a tsnmap.  */
-void sctp_tsnmap_free(struct sctp_tsnmap *map)
-{
-	if (map->malloced)
-		kfree(map);
-}
-
 /* Initialize a Gap Ack Block iterator from memory being provided.  */
-void sctp_tsnmap_iter_init(const struct sctp_tsnmap *map,
-			   struct sctp_tsnmap_iter *iter)
+static void sctp_tsnmap_iter_init(const struct sctp_tsnmap *map,
+				  struct sctp_tsnmap_iter *iter)
 {
 	/* Only start looking one past the Cumulative TSN Ack Point.  */
 	iter->start = map->cumulative_tsn_ack_point + 1;
@@ -186,8 +156,9 @@
 /* Get the next Gap Ack Blocks. Returns 0 if there was not another block
  * to get.
  */
-int sctp_tsnmap_next_gap_ack(const struct sctp_tsnmap *map,
-	struct sctp_tsnmap_iter *iter, __u16 *start, __u16 *end)
+static int sctp_tsnmap_next_gap_ack(const struct sctp_tsnmap *map,
+				    struct sctp_tsnmap_iter *iter,
+				    __u16 *start, __u16 *end)
 {
 	int started, ended;
 	__u16 _start, _end, offset;
--- linux-2.6.10-rc2-mm3-full/include/net/sctp/ulpevent.h.old	2004-11-25 02:26:08.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/net/sctp/ulpevent.h	2004-11-25 02:26:19.000000000 +0100
@@ -77,8 +77,6 @@
 	return (struct sctp_ulpevent *)skb->cb;
 }
 
-struct sctp_ulpevent *sctp_ulpevent_new(int size, int flags, int gfp);
-void sctp_ulpevent_init(struct sctp_ulpevent *, int flags);
 void sctp_ulpevent_free(struct sctp_ulpevent *);
 int sctp_ulpevent_is_notification(const struct sctp_ulpevent *);
 void sctp_queue_purge_ulpevents(struct sk_buff_head *list);
--- linux-2.6.10-rc2-mm3-full/net/sctp/ulpevent.c.old	2004-11-25 02:26:26.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/ulpevent.c	2004-11-25 02:27:38.000000000 +0100
@@ -65,8 +65,17 @@
  */
 }
 
+/* Initialize an ULP event from an given skb.  */
+static void sctp_ulpevent_init(struct sctp_ulpevent *event, int msg_flags)
+{
+	memset(event, 0, sizeof(struct sctp_ulpevent));
+	event->msg_flags = msg_flags;
+}
+
 /* Create a new sctp_ulpevent.  */
-struct sctp_ulpevent *sctp_ulpevent_new(int size, int msg_flags, int gfp)
+static struct sctp_ulpevent *sctp_ulpevent_new(int size,
+					       int msg_flags,
+					       int gfp)
 {
 	struct sctp_ulpevent *event;
 	struct sk_buff *skb;
@@ -84,13 +93,6 @@
 	return NULL;
 }
 
-/* Initialize an ULP event from an given skb.  */
-void sctp_ulpevent_init(struct sctp_ulpevent *event, int msg_flags)
-{
-	memset(event, 0, sizeof(struct sctp_ulpevent));
-	event->msg_flags = msg_flags;
-}
-
 /* Is this a MSG_NOTIFICATION?  */
 int sctp_ulpevent_is_notification(const struct sctp_ulpevent *event)
 {
--- linux-2.6.10-rc2-mm3-full/include/net/sctp/ulpqueue.h.old	2004-11-25 02:28:27.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/net/sctp/ulpqueue.h	2004-11-25 02:28:36.000000000 +0100
@@ -57,7 +57,6 @@
 };
 
 /* Prototypes. */
-struct sctp_ulpq *sctp_ulpq_new(struct sctp_association *asoc, int gfp);
 struct sctp_ulpq *sctp_ulpq_init(struct sctp_ulpq *,
 				 struct sctp_association *);
 void sctp_ulpq_free(struct sctp_ulpq *);
--- linux-2.6.10-rc2-mm3-full/net/sctp/ulpqueue.c.old	2004-11-25 02:28:44.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/net/sctp/ulpqueue.c	2004-11-25 02:28:58.000000000 +0100
@@ -56,25 +56,6 @@
 
 /* 1st Level Abstractions */
 
-/* Create a new ULP queue.  */
-struct sctp_ulpq *sctp_ulpq_new(struct sctp_association *asoc, int gfp)
-{
-	struct sctp_ulpq *ulpq;
-
-	ulpq = kmalloc(sizeof(struct sctp_ulpq), gfp);
-	if (!ulpq)
-		goto fail;
-	if (!sctp_ulpq_init(ulpq, asoc))
-		goto fail_init;
-	ulpq->malloced = 1;
-	return ulpq;
-
-fail_init:
-	kfree(ulpq);
-fail:
-	return NULL;
-}
-
 /* Initialize a ULP queue from a block of memory.  */
 struct sctp_ulpq *sctp_ulpq_init(struct sctp_ulpq *ulpq,
 				 struct sctp_association *asoc)
@@ -92,7 +73,7 @@
 
 
 /* Flush the reassembly and ordering queues.  */
-void sctp_ulpq_flush(struct sctp_ulpq *ulpq)
+static void sctp_ulpq_flush(struct sctp_ulpq *ulpq)
 {
 	struct sk_buff *skb;
 	struct sctp_ulpevent *event;

