Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWBVUjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWBVUjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWBVUjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:39:00 -0500
Received: from mail-relay.finepoint.com ([209.208.171.51]:36488 "EHLO
	mail-relay.finepoint.com") by vger.kernel.org with ESMTP
	id S1751117AbWBVUjA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:39:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Fork() issue
Date: Wed, 22 Feb 2006 15:38:58 -0500
Message-ID: <DE026503646E7F40AF97BAB98334333B0122C3AB@uss-republic.finepoint.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fork() issue
Thread-Index: AcY38AGEVhTXsAPTRi2ZftdfqffzeA==
From: "Hai Wang" <hwang@finepoint.com>
To: <linux-kernel@vger.kernel.org>
X-Spam-Score: undef - SENDER Whitelisted (Sender hwang@finepoint.com is whitelisted)
X-Canit-Stats-ID: Bayes signature not available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

    I encountered a problem with linux kernel, please help if you can.

    I am writing an application which is listening to multiple sockets.

 

    Scenario I:
    

    Say, the application is listening to 6000 sockets, while a socket receives any packet, the application will close the socket and fork a child process to reopen the socket and do the packets processes and so on. But for some reasons, the application could not fork more than 1000 child processes due to fork function failure as indicated in the following kernel code

 

       do_fork()->......copy_files()-> ... expand_fd_array()->...alloc_fd_array()à vmalloc ()->get_vm_area(){

       ........

           if (addr > VMALLOC_END-size) {

                        

                 goto out;

            }

       }

 

    It seems to me that VMALLOC_END is out of boundary, but system still has plenty of memory left and CONFIG_HIGHMEM4G enabled

 

 

    If I disabled CONFIG_HIGHMEM4G, then the application can fork more than 1000 child processes until memory exhausted.

 

 

    While CONFIG_HIGHMEM4G is enabled, we reduced # of sockets to be listened, then # of child processes which can be forked will be increased, but fork still failed at the same located above before the memory exhausted.

    

    

    My system settings:

 

1.    2G memory

2.    Redhat9 with kernel 2.4.25

3.    file_max = 102400

4.    ulimit -n

   	core file size        (blocks, -c) unlimited

   	data seg size         (kbytes, -d) unlimited

    	file size             (blocks, -f) unlimited

    	max locked memory     (kbytes, -l) unlimited

    	max memory size       (kbytes, -m) unlimited

    	open files                    (-n) 102398

   	pipe size          (512 bytes, -p) 8

  	stack size            (kbytes, -s) 8192

  	cpu time             (seconds, -t) unlimited

  	max user processes            (-u) 6143

   	virtual memory        (kbytes, -v) unlimited

 

    5. define __FD_SETSIZE      102400

   

 

    It seems to me that fork might take the wrong VMALLOC_END when CONFIG_HIGHMEM4G is enabled, I have no clue on where I should look into, and any help is much appreciated.

 

 

Thanks!

 

Hai Wang

