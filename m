Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTIHTkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbTIHTkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:40:41 -0400
Received: from gprs145-40.eurotel.cz ([160.218.145.40]:35713 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263552AbTIHTkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:40:37 -0400
Date: Mon, 8 Sep 2003 21:38:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: Paul.Clements@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [NBD] patch and documentation
Message-ID: <20030908193838.GA435@elf.ucw.cz>
References: <3F5CB554.5040507@upb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5CB554.5040507@upb.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Paul, do you think this docs could be added to the end of
Documentation/nbd.txt?

The patch also looks harmless enough for applying ;-).
								Pavel

> The patch i attached defines max_sectors for each NBD device to be 256 
> which is 128KB as described in the protocol description i attached.
> The value 255 which is default in 2.4 kernels is not optimal. See my 
> other posting in the lkml to read why.
> The patch seems to work fine. My server-implementation receives one 
> 128KB request as expected instead of two 127KB and 1Kb requests.
> 
> Even if 256 is the new max_sectors-default of kernel 2.6, the patch 
> should be applied since the value should be part of the protocol 
> specification and therefor part of nbd.c
> 
> The documentation i attached should be published somewhere. For example 
> on nbd.sf.net since we didn't find one source where all the information 
> is collected.
> 
> Thx
>   Sven


> The NBD-protocol
> 
> How it works:
>     To use the NBD features of the kernel you must compile the kernel module
>    	called "Network block device support" (CONFIG_BLK_DEV_NBD). After you've
>    	loaded the module the devices will appear in /dev/nbd/ if you're using
>    	devfs. If you're not using devfs you will possibly need to create your
>    	device-nodes with "mknod". All NBD devices have major ID 43. /dev/nbd/0
>    	has minor ID 0, /dev/nbd/1 has minor ID 1 and so on.
>     To connect a NBD device to a remote server you need install the NBD tools
>     downloadable at http://nbd.sf.net or http://sf.net/projects/nbd. Run 
>     "nbd-client <host> <tcp-port> /dev/nbd/0" to connect the device /dev/nbd/0
>     to the remote server. nbd-client will open a TCP-connection to the server
>     and waits for some initial data which contains the size of the device.
>     Than the handle of the TCP-connection is transferred to the kernel for
>     further use. nbd-client will fork into background because the handle of the
>     TCP-connection would be closed by the kernel if nbd-client exits.
>     The tools also contain a very basic NBD server which will enable you to use
>     any file or device as a NBD.
> 
> The protocol:
>     The protocol is based on top of TCP/IP. Both client and server send packets
>     to each other. The server must send an init-packet to the client if a
>     client connects. After that the server just receives request-packets from
>     the client and sends back reply-packets until the connection is closed or a
>     disconnect-request is received.
>     
>     The amount of data that can be read or written with one request
>     is limited to 128KB.
> 
>     The current implementation of the NBD-protocol in the Linux-Kernel does
>     send multiple requests without waiting for replies. So it does make sense
>     for the server to handle requests in parallel.
>     
> Constants:
> 	INIT_PASSWD   = "NBDMAGIC"
> 	INIT_MAGIC    = 0x0000420281861253
>     REQUEST_MAGIC = 0x25609513
> 	REPLY_MAGIC   = 0x67446698
> 	
> 	REQUEST_READ       = 0
> 	REQUEST_WRITE      = 1
> 	REQUEST_DISCONNECT = 2
> 
> Packets:
> 	
> 	init-packet:
> 		passwd   : 8 bytes (string)  = INIT_PASSWD
> 		magic    : 8 bytes (integer) = INIT_MAGIC
> 		size     : 8 bytes (integer) = size of the device in bytes
> 		reserved : 128 bytes (filled with zeros)
> 	
> 	request-packet:
> 	    magic  : 4 bytes (integer) = REQUEST_MAGIC
> 	    type   : 4 bytes (integer) = REQUEST_READ, REQUEST_WRITE or REQUEST_DISCONNECT
> 	    handle : 8 bytes (integer) = request-handle
> 	    from   : 8 bytes (integer) = start offset for read/write-operation in bytes
> 	    length : 4 bytes (integer) = length of the read/write-operationion bytes
> 	    data   : x bytes (only for write request, x = length field of this packet)
> 
> 	reply-packet:
> 	    magic  : 4 bytes (integer) = REPLY_MAGIC
> 	    error  : 4 bytes (integer) = errorcode (0 = no error)
> 	    handle : 8 bytes (integer) = copy of request-handle
> 	    data   : x bytes (only for reply to read request and if no error occured,
> 	                      x = length field of the request packet)
> 
> 	all integer values are stored unsigned and in network-byte-order (big-endian)

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
