Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbWHUMDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWHUMDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWHUMDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:03:35 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:38909 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965074AbWHUMDe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:03:34 -0400
Message-ID: <44E9A114.6040605@de.ibm.com>
Date: Mon, 21 Aug 2006 14:03:32 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
Subject: Re: [2.6.19 PATCH 5/7] ehea: main header files
References: <200608181334.57701.ossthema@de.ibm.com> <20060818180345.9660E67B64@ozlabs.org>
In-Reply-To: <20060818180345.9660E67B64@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Neuling wrote:
 >> +static inline void ehea_update_sqa(struct ehea_qp *qp, u16 nr_wqes)
 >> +{
 >> +    struct h_epa epa = qp->epas.kernel;
 >> +    epa_store_acc(epa, QPTEMM_OFFSET(qpx_sqa),
 >> +                  EHEA_BMASK_SET(QPX_SQA_VALUE, nr_wqes));
 >> +}
 >> +
 >> +static inline void ehea_update_rq3a(struct ehea_qp *qp, u16 nr_wqes)
 >> +{
 >> +    struct h_epa epa = qp->epas.kernel;
 >> +    epa_store_acc(epa, QPTEMM_OFFSET(qpx_rq3a),
 >> +                  EHEA_BMASK_SET(QPX_RQ1A_VALUE, nr_wqes));
 >> +}
 >> +
 >> +static inline void ehea_update_rq2a(struct ehea_qp *qp, u16 nr_wqes)
 >> +{
 >> +    struct h_epa epa = qp->epas.kernel;
 >> +    epa_store_acc(epa, QPTEMM_OFFSET(qpx_rq2a),
 >> +                  EHEA_BMASK_SET(QPX_RQ1A_VALUE, nr_wqes));
 >> +}
 >> +
 >> +static inline void ehea_update_rq1a(struct ehea_qp *qp, u16 nr_wqes)
 >> +{
 >> +    struct h_epa epa = qp->epas.kernel;
 >> +    epa_store_acc(epa, QPTEMM_OFFSET(qpx_rq1a),
 >> +                  EHEA_BMASK_SET(QPX_RQ1A_VALUE, nr_wqes));
 >> +}
 >> +
 >> +static inline void ehea_update_feca(struct ehea_cq *cq, u32 nr_cqes)
 >> +{
 >> +    struct h_epa epa = cq->epas.kernel;
 >> +    epa_store_acc(epa, CQTEMM_OFFSET(cqx_feca),
 >> +                  EHEA_BMASK_SET(CQX_FECADDER, nr_cqes));
 >> +}
 >> +
 >> +static inline void ehea_reset_cq_n1(struct ehea_cq *cq)
 >> +{
 >> +    struct h_epa epa = cq->epas.kernel;
 >> +    epa_store_cq(epa, cqx_n1,
 >> +                 EHEA_BMASK_SET(CQX_N1_GENERATE_COMP_EVENT, 1));
 >> +}
 >> +
 >> +static inline void ehea_reset_cq_ep(struct ehea_cq *my_cq)
 >> +{
 >> +    struct h_epa epa = my_cq->epas.kernel;
 >> +    epa_store_acc(epa, CQTEMM_OFFSET(cqx_ep),
 >> +                  EHEA_BMASK_SET(CQX_EP_EVENT_PENDING, 0));
 >> +}
 >
 > These are almost identical... I'm sure most (if not all) could be merged
 > into a single function or #define.
 >
 > Mikey

Hi Mikey,

I gave it a try: ehea_reset_cq_n1() drops out because it calls epa_store_cq(),
not epa_store_acc(). ehea_update_feca() and ehea_reset_cq_ep() require a
different input parm as the others and replacing two inline functions by
one inline function and two macros doesn't help neither the code nor does
it improve readability.
Finally we have ehea_update_sqa() and the 3 ehea_update_rqXa() functions which
I replaced by an inline function and four macros. See the result below. It
think understanding what this does is way more difficult than looking at the
four inline functions we had before. Therefore I'd prefer leaving those inline
functions as is.

Regards
Thomas


#define ehea_update_sqa(qp, nr_wqes) \
         ehea_update_qa(qp, nr_wqes, \
                        QPTEMM_OFFSET(qpx_sqa), \
                        EHEA_BMASK_SET(QPX_SQA_VALUE, nr_wqes));

#define ehea_update_rq1a(qp, nr_wqes) \
         ehea_update_qa(qp, nr_wqes, \
                        QPTEMM_OFFSET(qpx_rq1a), \
                        EHEA_BMASK_SET(QPX_RQ1A_VALUE, nr_wqes));

#define ehea_update_rq2a(qp, nr_wqes) \
         ehea_update_qa(qp, nr_wqes, \
                        QPTEMM_OFFSET(qpx_rq2a), \
                        EHEA_BMASK_SET(QPX_RQ2A_VALUE, nr_wqes));

#define ehea_update_rq3a(qp, nr_wqes) \
         ehea_update_qa(qp, nr_wqes, \
                        QPTEMM_OFFSET(qpx_rq3a), \
                        EHEA_BMASK_SET(QPX_RQ3A_VALUE, nr_wqes));

static inline void ehea_update_qa(struct ehea_qp *qp, u16 nr_wqes,
                                   u32 offset, u64 value)
{
         struct h_epa epa = qp->epas.kernel;
         epa_store_acc(epa, offset, value);
}

