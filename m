Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbTCVJjV>; Sat, 22 Mar 2003 04:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262079AbTCVJjV>; Sat, 22 Mar 2003 04:39:21 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:28096 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S262078AbTCVJjT>;
	Sat, 22 Mar 2003 04:39:19 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303220950.h2M9oLB05748@csl.stanford.edu>
Subject: [CHECKER] deadlock in 2.5.62/net/sctp/input.c?
To: linux-kernel@vger.kernel.org
Date: Sat, 22 Mar 2003 01:50:21 -0800 (PST)
Cc: engler@csl.stanford.edu (Dawson Engler)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

here's a potential locking cycle in 
	2.5.62/net/sctp/input.c.  
Confirmation/correction appreciated.

Thanks,
Dawson

ERROR: 1 thread local-local deadlock.
   <sctp_hashbucket_t.lock>-><sctp_endpoint_common_t.addr_lock> occurred 2 times
   <sctp_endpoint_common_t.addr_lock>-><sctp_hashbucket_t.lock> occurred 2 times

    depth = 2:
        net/sctp/input.c:__sctp_lookup_association:634
           ->net/sctp/input.c:__sctp_lookup_association:634

        hash = sctp_assoc_hashfn(laddr->v4.sin_port, paddr->v4.sin_port);
        head = &sctp_proto.assoc_hashbucket[hash];
        read_lock(&head->lock);
        for (epb = head->chain; epb; epb = epb->next) {
                asoc = sctp_assoc(epb);
                transport = sctp_assoc_is_match(asoc, laddr, paddr);

           ->__sctp_lookup_association:637
           ->end=net/sctp/associola.c:sctp_assoc_is_match:754:read_lock
           ->net/sctp/associola.c:sctp_assoc_is_match:754

        sctp_read_lock(&asoc->base.addr_lock);


    depth = 2:
        net/sctp/input.c:__sctp_rcv_lookup_endpoint:536
           ->net/sctp/input.c:__sctp_rcv_lookup_endpoint:536
           ->__sctp_rcv_lookup_endpoint:539
           ->end=net/sctp/endpointola.c:sctp_endpoint_is_match:241:read_lock

While the readlocks are recursive, can be called in a place without
*->base.addr_lock held (e.g., sctp_v4_err).

  <sctp_endpoint_common_t.addr_lock>-><sctp_hashbucket_t.lock> =
    depth = 4:
        net/sctp/endpointola.c:sctp_endpoint_is_peeled_off:313
           ->net/sctp/endpointola.c:sctp_endpoint_is_peeled_off:313
           ->sctp_endpoint_is_peeled_off:317

        sctp_read_lock(&ep->base.addr_lock);
        bp = &ep->base.bind_addr;
        list_for_each(pos, &bp->address_list) {
                addr = list_entry(pos, struct sockaddr_storage_list, list);
                if (sctp_has_association(&addr->a, paddr)) {

           ->net/sctp/input.c:sctp_has_association:675
           ->sctp_lookup_association:662
           ->end=__sctp_lookup_association:634:read_lock
