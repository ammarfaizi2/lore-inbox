Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRDEWrF>; Thu, 5 Apr 2001 18:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRDEWq4>; Thu, 5 Apr 2001 18:46:56 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:52200 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S129346AbRDEWqk>;
	Thu, 5 Apr 2001 18:46:40 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200104052245.PAA29663@csl.Stanford.EDU>
Subject: [CHECKER] 3 kmalloc underallocation bugs
To: linux-kernel@vger.kernel.org
Date: Thu, 5 Apr 2001 15:45:47 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

enclosed are three bugs found in the 2.4.1 kernel by an extension
that checks that kmalloc calls allocate enough memory.  It examines all
callsites of the form:
	p = [kv]malloc(nbytes);
and issues an error if
	sizeof *p < nbytes

I think they're all currently harmless because of kmalloc & friends
exuberant approach to padding.

Dawson

drivers/sound/emu10k1/midi.c
drivers/telephony/ixj.c
---------------------------------------------------------
[BUG]  should allocate sizeof *midihdr

/u2/engler/mc/oses/linux/2.4.1/drivers/sound/emu10k1/midi.c:59:midiin_add_buffer
: ERROR:SIZE-CHECK:59:59: midihdr = 'kmalloc'(4 bytes), need 32


static int midiin_add_buffer(struct emu10k1_mididevice *midi_dev, struct midi_hd
r **midihdrptr)
{
        struct midi_hdr *midihdr;

Error --->
        if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct midi_hdr *), GF
P_KERNEL)) == NULL) {
                ERROR();
                return -EINVAL;
        }

---------------------------------------------------------
[BUG] same
/u2/engler/mc/oses/linux/2.4.1/drivers/sound/emu10k1/midi.c:331:emu10k1_midi_wri
te: ERROR:SIZE-CHECK:331:331: midihdr = 'kmalloc'(4 bytes), need 32

        struct midi_hdr *midihdr;
        ssize_t ret = 0;
        unsigned long flags;

        DPD(4, "emu10k1_midi_write(), count=%x\n", (u32) count);

        if (pos != &file->f_pos)
                return -ESPIPE;

        if (!access_ok(VERIFY_READ, buffer, count))
                return -EFAULT;

Error --->
        if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct midi_hdr *), GF
P_KERNEL)) == NULL)
                return -EINVAL;

---------------------------------------------------------
[BUG]  should be sizeof(IXJ_FILTER_CADENCE) as with the copy_from_user

/u2/engler/mc/oses/linux/2.4.1/drivers/telephony/ixj.c:4511:ixj_build_filter_cad
ence: ERROR:SIZE-CHECK:4511:4511: lcp = 'kmalloc'(12 bytes), need 32


        ... DELETED 7 lines ...

        IXJ_FILTER_CADENCE *lcp;
        IXJ *j = &ixj[board];
Error --->
        lcp = kmalloc(sizeof(IXJ_CADENCE), GFP_KERNEL);
        if (lcp == NULL)
                return -ENOMEM;
        if (copy_from_user(lcp, (char *) cp, sizeof(IXJ_FILTER_CADENCE)))
                return -EFAULT;
----------------------------------------


