Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283561AbRLDWty>; Tue, 4 Dec 2001 17:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283572AbRLDWto>; Tue, 4 Dec 2001 17:49:44 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:31104 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S283561AbRLDWt3>; Tue, 4 Dec 2001 17:49:29 -0500
Message-ID: <3C0D52F1.5020800@optonline.net>
Date: Tue, 04 Dec 2001 17:49:21 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Doug Ledford <dledford@redhat.com>, Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> this may be due to an output underrun... or i suppose lost interrupt 
> is also possible.
>
> i think it might be wise to use 
> get_available_read_data/get_free_write_space from i810_poll instead of 
> dmabuf->count directly. i'll try this and see if it works... 

No good. I tried the following, thinking that the underrun handling in 
get_free_write_space would help, but it does the same thing.

What interrupt do we get upon underrun, are we dropping the 
dmabuf->enable or DAC_RUNNING state when that happens?

--

static unsigned int i810_poll(struct file *file, struct 
poll_table_struct *wait){
        struct i810_state *state = (struct i810_state *)file->private_data;
        struct dmabuf *dmabuf = &state->dmabuf;
        unsigned long flags;
        unsigned int mask = 0;
        int count;

        if(!dmabuf->ready)
                return 0;
        poll_wait(file, &dmabuf->wait, wait);
        spin_lock_irqsave(&state->card->lock, flags);
        if (file->f_mode & FMODE_READ && dmabuf->enable & ADC_RUNNING) {
                count = i810_get_available_read_data(state);
                if (count >= (signed)dmabuf->userfragsize)
                        mask |= POLLIN | POLLRDNORM;
        }
        if (file->f_mode & FMODE_WRITE && dmabuf->enable & DAC_RUNNING) {
                count = i810_get_free_write_space(state);
                if (count >= (signed)dmabuf->userfragsize)
                        mask |= POLLOUT | POLLWRNORM;
        }
        spin_unlock_irqrestore(&state->card->lock, flags);
        return mask;
}

