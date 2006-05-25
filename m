Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWEYXvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWEYXvV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 19:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWEYXvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 19:51:21 -0400
Received: from smtpout05-04.prod.mesa1.secureserver.net ([64.202.165.221]:4054
	"HELO smtpout05-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S965193AbWEYXvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 19:51:20 -0400
Message-ID: <447642F6.5030807@seclark.us>
Date: Thu, 25 May 2006 19:51:18 -0400
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Clark <sclark@netwolves.com>
CC: Willy TARREAU <willy@w.ods.org>, Steve Clark <sclark@dev.netwolves.com>,
       linux-kernel@vger.kernel.org,
       uClinux development list <uclinux-dev@uclinux.org>
Subject: Re: uclinux 2.4.32 panic
References: <44746064.30607@netwolves.com> <20060524201030.GU11191@w.ods.org> <4474CF11.4090007@netwolves.com> <20060525063414.GA249@w.ods.org> <4475BB05.6050001@netwolves.com>
In-Reply-To: <4475BB05.6050001@netwolves.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Clark wrote:

>Hi Willy,
>
>Thanks for your analysis - see my comments below;
>
>Steve
>
>Willy TARREAU wrote:
>  
>
>>On Wed, May 24, 2006 at 05:24:33PM -0400, Steve Clark wrote:
>>(...)
>>
>>    
>>
>>>>>>>LR;  008727cc <rs_write+148/294>
>>>>>>>              
>>>>>>>
>>>>>>>PC;  0090e5fc <memmove+25c/460>   <=====
>>>>>>>              
>>>>>>>
>>>>>Trace; 0090e3a0 <memcpy+0/0>
>>>>>Trace; 008727cc <rs_write+148/294>
>>>>>
>>>>>          
>>>>>
>>>>>>>r8; 00956228 <tmp_buf+0/1000>
>>>>>>>              
>>>>>>>
>>>>>Trace; 00872684 <rs_write+0/294>
>>>>>          
>>>>>
>>(...)
>>
>>
>>    
>>
>>>The hardware is the ActionTec DualPC Modem it has a conexant cx82100 
>>>arm processor.
>>>I can reproduce it at will by connecting to the internet and running 
>>>nttcp thru it at the same time
>>>I am scping file both ways from and to, and then finally starting a 
>>>getty on /dev/ttyS0, the modem is
>>>at ttyS1 and also ttyS0 is where all the kernel printk messages come out.
>>>
>>>When I start the getty if I have all the other traffic going it 
>>>usually will panic in under a minute. IF I don't
>>>have the getty running it will run for hours and not panic.
>>>
>>>
>>>
>>>2.4.32-uc0 with patches from
>>>http://www.bettina-attack.de/jonny/view.php/projects/uclinux_on_cx82100/
>>>      
>>>
>>Well, at least the cnxtserial.c file looks suspicious to me :
>>
>>static int rs_write(struct tty_struct * tty, int from_user,
>>                    const unsigned char *buf, int count)
>>{
>>        int     c, total = 0;
>>        unsigned long flags;
>>        struct cnxt_serial *info = (struct cnxt_serial *)tty->driver_data;
>>                                                         ^^^^^
>>
>>        if (serial_paranoia_check(info,tty->device, "rs_write"))
>>                                       ^^^^^
>>          return 0;
>>
>>        if (!tty || !info->xmit_buf)
>>          return 0;
>>
>>=> tty already referenced twice before the check. Either the check is
>>   useless, or the person who wrote it had a good reason for it which
>>   was not considered when writing the two lines above. I would suggest
>>   to start from something like this :
>>
>>static int rs_write(struct tty_struct * tty, int from_user,
>>                    const unsigned char *buf, int count)
>>{
>>        int     c, total = 0;
>>        unsigned long flags;
>>        struct cnxt_serial *info;
>>
>>        if (!tty)
>>        	return 0;
>>
>>        info = (struct cnxt_serial *)tty->driver_data;
>>        if (serial_paranoia_check(info, tty->device, "rs_write"))
>>        	return 0;
>>
>>        if (!info->xmit_buf)
>>        	return 0;
>>    
>>
>
>I did this - actually I matched to serial.c
>  
>
>>Further :
>>
>>          c = MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
>>                             SERIAL_XMIT_SIZE - info->xmit_head));
>>          if (c <= 0)
>>            break;
>>
>>=> info->xmit_cnt and info->xmit_head are signed ints. If you encounter
>>   memory corruption (eg: during your ethernet transfers) and those get
>>   negative, nothing prevents the buffer from being overwritten past the
>>   end.
>>
>>Further :
>>
>>          if (from_user) {
>>            down(&tmp_buf_sem);
>>            copy_from_user(tmp_buf, buf, c);
>>            c = MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
>>                           SERIAL_XMIT_SIZE - info->xmit_head));
>>        ^^^^^^^^^^^^^^^^^^
>>            memcpy(info->xmit_buf + info->xmit_head, tmp_buf, c);
>>            up(&tmp_buf_sem);
>>          } else
>>
>>=> What the hell is this ? c was assigned the same value above, so
>>   we get :
>>   c = MIN(MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
>>                       SERIAL_XMIT_SIZE - info->xmit_head)),
>>                      MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
>>                       SERIAL_XMIT_SIZE - info->xmit_head));
>>
>>   I'm not sure this was what the developper originally intented to do,
>>   but although useless, it does not seem incorrect. However, I don't
>>   know if he wanted to further reduce the buffer for any reason.
>>
>>Also, it appears that nothing prevents any code running outside the
>>loop from changing info->xmit_buf between the restore_flags() and
>>the cli(). I don't know if this is functionnaly possible, but at
>>least it is possible by memory corruption (eg: padding too large
>>for a packet and writing zeroes past the end of one buffer).
>>
>>    
>>
>I moved the cli() outside of the while loop - similar to serial.c
>
>  
>
>>You should definitely add printks or at least double checks
>>everywhere within this loop I think.
>>
>>    
>>
>I did and info->xmit_head is getting clobbered!
>see below:
>  
>
>>That's all I can tell, I don't know this platform at all.
>>
>>Regards,
>>Willy
>>
>>
>>
>>    
>>
>xmit_buf+head=a2279c,tmp_buf=956228,c=250
>rs_write:xmit_buf=a22000,tmp_buf=956228
>xmit_buf+head=a22896,tmp_buf=956228,c=250
>rs_write:xmit_buf=a22000,tmp_buf=956228
>xmit_buf+head=a22990,tmp_buf=956228,c=19
>rs_write:xmit_buf=170f1200,tmp_buf=956228
>                               ^^^^^^
>xmit_buf+head=170f1200,tmp_buf=956228,c=13
>Unable to handle kernel NULL pointer dereference at virtual address 
>0000003f
>fault-common.c(97): start_code=0xdc4040, start_stack=0xe11f38)
>Internal error: Oops: ffffffff
>CPU: 0
>pc : [<0090e6a0>]    lr : [<00872808>]    Not tainted
>sp : 00a1fe94  ip : 00000001  fp : 00a1feb8
>r10: 00000fff  r9 : 00956228  r8 : 0093d26c
>r7 : 0000000d  r6 : 009922a0  r5 : 00955f00  r4 : 0000000d
>r3 : 0000007e  r2 : 00000009  r1 : 009922ac  r0 : 170f120d
>Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  Segment user
>Control: C000107D
>Process pppd (pid: 64, stackpage=00a1f000)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Thanks Willy,

I tracked down the problem it was in the receive_chars(). Whoever did 
this had an #if 0
that removed the test of the flip buffer count exceeding the flip buffer 
size, so under
stress the buffer would overflow and zero the pointer stored in 
driver_data field.

Steve

Code excerpt:
    if(!tty)
    {
      printk("no tty\n");
      goto clear_and_exit;
    }
#if 0
    if (tty->flip.count >= TTY_FLIPBUF_SIZE)
        queue_task_irq_off(&tty->flip.tqueue, &tq_timer);
    tty->flip.count++;
    if(status & US_PARE)
        *tty->flip.flag_buf_ptr++ = TTY_PARITY;
    else if(status & US_OVRE)
        *tty->flip.flag_buf_ptr++ = TTY_OVERRUN;
    else if(status & US_FRAME)
        *tty->flip.flag_buf_ptr++ = TTY_FRAME;
    else
        *tty->flip.flag_buf_ptr++ = 0;
#endif
        tty->flip.count++;
        *tty->flip.flag_buf_ptr++ = 0;
    *tty->flip.char_buf_ptr++ = ch;

   
    queue_task(&tty->flip.tqueue, &tq_timer);
   

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



