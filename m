Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbTIHQ6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbTIHQ6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:58:30 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:34229 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S262734AbTIHQ60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:58:26 -0400
Message-ID: <3F5CB554.5040507@upb.de>
Date: Mon, 08 Sep 2003 18:59:00 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030818
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul.Clements@steeleye.com
CC: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: [NBD] patch and documentation
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010700040909010009000906"
X-MailScanner-Information: Please see http://imap.upb.de for details
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.8, required 4,
	USER_AGENT_MOZILLA_UA -5.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010700040909010009000906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The patch i attached defines max_sectors for each NBD device to be 256 
which is 128KB as described in the protocol description i attached.
The value 255 which is default in 2.4 kernels is not optimal. See my 
other posting in the lkml to read why.
The patch seems to work fine. My server-implementation receives one 
128KB request as expected instead of two 127KB and 1Kb requests.

Even if 256 is the new max_sectors-default of kernel 2.6, the patch 
should be applied since the value should be part of the protocol 
specification and therefor part of nbd.c

The documentation i attached should be published somewhere. For example 
on nbd.sf.net since we didn't find one source where all the information 
is collected.

Thx
   Sven

--------------010700040909010009000906
Content-Type: application/gzip;
 name="nbd-patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="nbd-patch.gz"

H4sICBWbXD8AA25iZC1wYXRjaAB9UlFT2kAYfA6/4huddoJJyCVCgtE6kBJnlICjEscpZW5C
crRXNLHJ4dD+ei8XAgLqPdzLt7vf7d5qmgZ6lqZMT6ZxI5JMhI41dKKhNhiW0zQdw2qg6oCC
+LymKArEGX0hWa5PH9No/g7XdpDhNI09bqcDWutEtUDhtw2dTg1qkLOQ0QhowoAr4enjPKf/
ST4edB/w0O1NTj+C4Cllb2HKDuwpXOYkYmn2mdZHuxZWs9z1j5E9TGnERsKJbaysSM8ZV53L
B5znQEZ+0ZyRjMQQkxcaEQgZPIV/0gy+xD+TAxUG3avrWzy8rXPFQ5LEdMY1Km/FNa4QE/i2
lQ33KnF3eGNvG7dxflpKvi+30ioRNKEM/12QBZFdv4973kU38Ef4JvACT14/VYU4xQU3Ixyb
s3pFF0z8m4RxGDHejs9FEOeJDNvHIsN2q8pQEu8YBCPvQf5aLOLhjemkwZa4KJvYJ231hBZ2
DGQ2d0dlP1bjIjJppxViZLasDXH92WIky7wFdbS0Z/xECNXh7KyQAv0IzJELR3pFfEPa0zk/
B9e//t7Hd5c/POxeju7EvqofOKb5XB4Gvs8b0e959+ucVMqTMlQQMczS51ytvQIjeiMasQMA
AA==
--------------010700040909010009000906
Content-Type: text/plain;
 name="protocol.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="protocol.txt"

The NBD-protocol

How it works:
    To use the NBD features of the kernel you must compile the kernel module
   	called "Network block device support" (CONFIG_BLK_DEV_NBD). After you've
   	loaded the module the devices will appear in /dev/nbd/ if you're using
   	devfs. If you're not using devfs you will possibly need to create your
   	device-nodes with "mknod". All NBD devices have major ID 43. /dev/nbd/0
   	has minor ID 0, /dev/nbd/1 has minor ID 1 and so on.
    To connect a NBD device to a remote server you need install the NBD tools
    downloadable at http://nbd.sf.net or http://sf.net/projects/nbd. Run 
    "nbd-client <host> <tcp-port> /dev/nbd/0" to connect the device /dev/nbd/0
    to the remote server. nbd-client will open a TCP-connection to the server
    and waits for some initial data which contains the size of the device.
    Than the handle of the TCP-connection is transferred to the kernel for
    further use. nbd-client will fork into background because the handle of the
    TCP-connection would be closed by the kernel if nbd-client exits.
    The tools also contain a very basic NBD server which will enable you to use
    any file or device as a NBD.

The protocol:
    The protocol is based on top of TCP/IP. Both client and server send packets
    to each other. The server must send an init-packet to the client if a
    client connects. After that the server just receives request-packets from
    the client and sends back reply-packets until the connection is closed or a
    disconnect-request is received.
    
    The amount of data that can be read or written with one request
    is limited to 128KB.

    The current implementation of the NBD-protocol in the Linux-Kernel does
    send multiple requests without waiting for replies. So it does make sense
    for the server to handle requests in parallel.
    
Constants:
	INIT_PASSWD   = "NBDMAGIC"
	INIT_MAGIC    = 0x0000420281861253
    REQUEST_MAGIC = 0x25609513
	REPLY_MAGIC   = 0x67446698
	
	REQUEST_READ       = 0
	REQUEST_WRITE      = 1
	REQUEST_DISCONNECT = 2

Packets:
	
	init-packet:
		passwd   : 8 bytes (string)  = INIT_PASSWD
		magic    : 8 bytes (integer) = INIT_MAGIC
		size     : 8 bytes (integer) = size of the device in bytes
		reserved : 128 bytes (filled with zeros)
	
	request-packet:
	    magic  : 4 bytes (integer) = REQUEST_MAGIC
	    type   : 4 bytes (integer) = REQUEST_READ, REQUEST_WRITE or REQUEST_DISCONNECT
	    handle : 8 bytes (integer) = request-handle
	    from   : 8 bytes (integer) = start offset for read/write-operation in bytes
	    length : 4 bytes (integer) = length of the read/write-operationion bytes
	    data   : x bytes (only for write request, x = length field of this packet)

	reply-packet:
	    magic  : 4 bytes (integer) = REPLY_MAGIC
	    error  : 4 bytes (integer) = errorcode (0 = no error)
	    handle : 8 bytes (integer) = copy of request-handle
	    data   : x bytes (only for reply to read request and if no error occured,
	                      x = length field of the request packet)

	all integer values are stored unsigned and in network-byte-order (big-endian)
--------------010700040909010009000906--

