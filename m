Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTJ1KSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 05:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbTJ1KSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 05:18:38 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:5033 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S263898AbTJ1KSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 05:18:36 -0500
Message-ID: <3F9E4275.9070201@yahoo.com>
Date: Tue, 28 Oct 2003 15:48:29 +0530
From: Balbir Singh <balbir_soni@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Questions on drivers returning POLLNVAL
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, All,

I seem to be problems with select() when I return POLLNVAL
from the poll() entry point of my driver.

For more context, I am attaching the following snippet of code
from fs/select.c (do_select). I am looking at 2.4.22

                        if (file) {
                                mask = DEFAULT_POLLMASK;
                                if (file->f_op && file->f_op->poll)
                                        mask = file->f_op->poll(file, wait);
                                fput(file);
                        }
                        if ((mask & POLLIN_SET) && ISSET(bit, 
__IN(fds,off))) {
                                SET(bit, __RES_IN(fds,off));
                                retval++;
                                wait = NULL;
                        }
                        if ((mask & POLLOUT_SET) && ISSET(bit, 
__OUT(fds,off)))
{
                                SET(bit, __RES_OUT(fds,off));
                                retval++;
                                wait = NULL;
                        }
                        if ((mask & POLLEX_SET) && ISSET(bit, 
__EX(fds,off))) {
                                SET(bit, __RES_EX(fds,off));
                                retval++;
                                wait = NULL;
                        }
                }
                wait = NULL;
                if (retval || !__timeout || signal_pending(current))
                        break;
                if(table.error) {
                        retval = table.error;
                        break;
                }
                __timeout = schedule_timeout(__timeout);


When I return POLLNVAL from my driver, the user set the select timeout set
to NULL, I get caught up in schedule_timeout.

when I pass NULL for timeout from userland, in the kernel, I
see __timeout  set to 2147483647. I have not investigated this yet.
Hence I fail the two checks for breaking out of the loop and
get stuck in schedule_timeout.

Am I expected to set POLLNVAL in table->error passed to the poll()
entry point explicitly?

Thanks,
Balbir

