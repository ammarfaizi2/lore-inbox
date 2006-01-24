Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWAXXoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWAXXoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWAXXoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:44:22 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:57786
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750846AbWAXXoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:44:21 -0500
Message-ID: <43D6BBCF.7090403@microgate.com>
Date: Tue, 24 Jan 2006 17:44:15 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: pppd oopses current linu's git tree on disconnect
References: <20060119010601.f259bb32.diegocg@gmail.com>	 <1137692039.3279.1.camel@amdx2.microgate.com>	 <20060119230746.ea78fcf4.diegocg@gmail.com> <43D01537.40705@microgate.com>	 <20060123034243.22ba0a8f.diegocg@gmail.com>	 <20060124044846.de6508eb.diegocg@gmail.com>	 <1138140391.3223.15.camel@amdx2.microgate.com> <1138145129.21284.12.camel@localhost.localdomain>
In-Reply-To: <1138145129.21284.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Yeah the new tty code assumed the same locking rules as the old tty code
> and nobody on the planet followed them since 2.2.

I could not find any code that used the tty read_lock
when pushing data. So at least its a clean start.

> I think you've been reading my mind, only you've actually come up with a
> slightly neater variant than I have half coded here.

OK, good.

>> int tty_prepare_flip_string(struct tty_struct *tty, unsigned char **chars, size_t size)
>> {
>> 	int space = tty_buffer_request_room(tty, size);
>>-	struct tty_buffer *tb = tty->buf.tail;
>>-	*chars = tb->char_buf_ptr + tb->used;
>>-	memset(tb->flag_buf_ptr + tb->used, TTY_NORMAL, space);
>>-	tb->used += space;
>>+	if (space) {
>>+		struct tty_buffer *tb = tty->buf.tail;
>>+		*chars = tb->char_buf_ptr + tb->used;
>>+		memset(tb->flag_buf_ptr + tb->used, TTY_NORMAL, space);
>>+		tb->used += space;
>>+	}

Unrelated, yes.
But if space == 0 then tty->buf.tail could be NULL
Touching tb could oops. I think you already do a similar
check in tty_insert_flip_string() etc.

>> static inline void con_schedule_flip(struct tty_struct *t)
> 
> Should die as a duplicate by the look of it, and the tty one probably
> should cease to be inline.

The only difference seems to be schedule_delayed_work()
in tty_schedule_flip() vs schedule_work() in con_schedule_flip().

All three:
tty_schedule_flip()
con_schedule_flip()
tty_flip_buffer_push()
seem to be duplicates other than that.

> Looks good to me.

There is still the esp and cyclades driver which
schedule the buf.work directly which need to be
switched to one of the above 3 functions.

I also found a case where the active flag
is not cleared correctly. (when a partial buffer is
filled and a new tail buffer is allocated before
calling one of the schedule functions.

I'll fix both of these up tomorrow, post a new
patch and continue testing.

Thanks,
Paul

--
Paul Fulghum
Microgate Systems, Ltd
