Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265496AbTFSUkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbTFSUkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:40:46 -0400
Received: from c3po.aoltw.net ([64.236.137.25]:23734 "EHLO netscape.com")
	by vger.kernel.org with ESMTP id S265496AbTFSUkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:40:31 -0400
Message-ID: <3EF22301.1000003@netscape.com>
Date: Thu, 19 Jun 2003 13:54:25 -0700
From: jgmyers@netscape.com (John Myers)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scot McKinley <scot.mckinley@oracle.com>
CC: Joel Becker <jlbec@evilplan.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH 2.5.71-mm1] aio process hang on EINVAL
References: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net> <3EEE6FD9.2050908@netscape.com> <20030617085408.A1934@in.ibm.com> <1055884008.1250.1479.camel@dell_ss5.pdx.osdl.net> <3EEFAC58.905@netscape.com> <20030618001534.GJ7895@parcelfarce.linux.theplanet.co.uk> <3EEFB165.5070208@netscape.com> <20030618004214.GK7895@parcelfarce.linux.theplanet.co.uk> <3EF104D7.5050905@netscape.com> <3EF11662.2060102@oracle.com>
In-Reply-To: <3EF11662.2060102@oracle.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080404040305040902080504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080404040305040902080504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Scot McKinley wrote:

> > The kernel could
> > even detect success during queuing if it really tried.
>
> Yes, this is also a good thing, as i mentioned in my earlier message.
> ie, if the io has ALREADY completed, return it immediately. 

io_submit() is incapable of returning operation success notifications.  
It can only return notifications of idempotent errors, since callers who 
submit multiple requests might need to call io_submit() twice to find 
out what the error was.

> Yes, the program WILL be able to handle async completions, obviously, 
> since
> it attempting aio submissions. However, it MAY also be able to handle
> synchronous/immediate completions of its aio submissions. 

"MAY" is far cry from "MUST".  I object strongly to requiring all 
callers to io_submit() to be able to handle immediate completions.  In 
my aio framework, the caller of io_submit() is not in a context where it 
can invoke completion callbacks, since completion callbacks are not 
required to be reentrant.

Adding an optional facility to permit callers to receive immediate 
completions is a different issue.

> > So?  That is a miniscule amount of resources used by an extremely rare
> > condition.  Such a picayune optimization hardly justifies the necessary
> > increase in complexity.
>
> It may not be miniscule.

For the specific conditions under discussion, it was.  The conditions 
were certainly extremely rare.

> As we expand the ability to do aio to network
> descriptors, the transport that we are utilizing could easily have a
> "bcopy threshold" (a bcopy thresheld, for those that don't know, is the
> threshold under which all io will be done synchronously.

The traditional way of dealing with this is to first call the 
synchronous nonblocking interface, retrying with the asynchronous 
interface only when the nonblocking one indicates no progress.  Not only 
does this save the cost of the (expensive when poll-based) queuing 
overhead, it can save the cost of operations required only when going 
async, such as copying the data from the stack to the heap.


--------------ms080404040305040902080504
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIL0zCC
A9YwggM/oAMCAQICBAIAAeYwDQYJKoZIhvcNAQEFBQAwRTELMAkGA1UEBhMCVVMxGDAWBgNV
BAoTD0dURSBDb3Jwb3JhdGlvbjEcMBoGA1UEAxMTR1RFIEN5YmVyVHJ1c3QgUm9vdDAeFw0w
MTA2MDExMjQ3MDBaFw0wNDA2MDEyMzU5MDBaMIGTMQswCQYDVQQGEwJVUzELMAkGA1UECBMC
Q0ExFjAUBgNVBAcTDU1vdW50YWluIFZpZXcxGzAZBgNVBAoTEkFtZXJpY2EgT25saW5lIElu
YzEZMBcGA1UECxMQQU9MIFRlY2hub2xvZ2llczEnMCUGA1UEAxMeSW50cmFuZXQgQ2VydGlm
aWNhdGUgQXV0aG9yaXR5MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDi718sdkOJSxpf
s+X4qm+LL4FNZ/+9Sg9jLsTchfaeLEkmIP8AF+SIiGne/YNX4KMRGRGq1ty877PSFS5Uxm58
v9m5w0bTCQWE5VNcSO2EhZoOOz0WB1zws3mrmhClvMGk0XhMBuVkQfwFJWMm6+8Mx25UoYzO
VFe2H5LashJLjQIDAQABo4IBgjCCAX4wTQYDVR0fBEYwRDBCoECgPoY8aHR0cDovL3d3dzEu
dXMtaG9zdGluZy5iYWx0aW1vcmUuY29tL2NnaS1iaW4vQ1JML0dURVJvb3QuY2dpMB0GA1Ud
DgQWBBQp27Itg35/iyO7wsxmuTnoKfMChjBmBgNVHSAEXzBdMEYGCiqGSIb4YwECAQUwODA2
BggrBgEFBQcCARYqaHR0cDovL3d3dy5iYWx0aW1vcmUuY29tL0NQUy9PbW5pUm9vdC5odG1s
MBMGAyoDBDAMMAoGCCsGAQUFBwIBMFgGA1UdIwRRME+hSaRHMEUxCzAJBgNVBAYTAlVTMRgw
FgYDVQQKEw9HVEUgQ29ycG9yYXRpb24xHDAaBgNVBAMTE0dURSBDeWJlclRydXN0IFJvb3SC
AgGjMCsGA1UdEAQkMCKADzIwMDEwNjAxMTI0NzMwWoEPMjAwMzA5MDEyMzU5MDBaMA4GA1Ud
DwEB/wQEAwIBBjAPBgNVHRMECDAGAQH/AgEBMA0GCSqGSIb3DQEBBQUAA4GBAEpiDtn6RncE
CmwN3f7SIjmZEAquiC2GPVeE5hIkN2n7WV7iEbD5n6RXhoppHwZj0X3uMzZJECAPH5cXLCds
PWw5BHviReiHG1S2YEFtHa4F8535OjSa43trTHH466grg7A1kEwZaHHt8GMiXsJb7CB6tbBR
c+kH7oFndnlT95XUMIID+DCCA2GgAwIBAgICbfowDQYJKoZIhvcNAQEFBQAwgZMxCzAJBgNV
BAYTAlVTMQswCQYDVQQIEwJDQTEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEbMBkGA1UEChMS
QW1lcmljYSBPbmxpbmUgSW5jMRkwFwYDVQQLExBBT0wgVGVjaG5vbG9naWVzMScwJQYDVQQD
Ex5JbnRyYW5ldCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwHhcNMDMwNjAzMDA1NjI3WhcNMDMx
MTMwMDA1NjI3WjB9MQswCQYDVQQGEwJVUzEbMBkGA1UEChMSQW1lcmljYSBPbmxpbmUgSW5j
MRcwFQYKCZImiZPyLGQBARMHamdteWVyczEjMCEGCSqGSIb3DQEJARYUamdteWVyc0BuZXRz
Y2FwZS5jb20xEzARBgNVBAMTCkpvaG4gTXllcnMwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJ
AoGBAK/NyY2CaWvkVG9fLKJvcJauEYngiqm3s4wwDjlMlhbRhRkLqzimtHIKOq3uJj/c6DwL
f1MhgLZJFDjQwpZO6XDOmmFnFP78G6bH0wd8oGyR309Lx/chgHS9uZqoBWnBa2vQw4KVIPAd
NNmRhh/29ruE+DdrCUj8de/vyJuGu6QNAgMBAAGjggFuMIIBajAOBgNVHQ8BAf8EBAMCBSAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMEMGCWCGSAGG+EIBDQQ2FjRJc3N1ZWQg
YnkgTmV0c2NhcGUgQ2VydGlmaWNhdGUgTWFuYWdlbWVudCBTeXN0ZW0gNC41MIGPBgNVHREE
gYcwgYSBFGpnbXllcnNAbmV0c2NhcGUuY29tgRBqZ215ZXJzQG1jb20uY29tgRNqb2huX215
ZXJzQG1jb20uY29tgRdqb2huX215ZXJzQG5ldHNjYXBlLmNvbYEXam9obmdteWVyc0BuZXRz
Y2FwZS5jb22BE2pvaG5nbXllcnNAbWNvbS5jb20wHwYDVR0jBBgwFoAUKduyLYN+f4sju8LM
Zrk56CnzAoYwQQYIKwYBBQUHAQEENTAzMDEGCCsGAQUFBzABhiVodHRwOi8vY2VydGlmaWNh
dGVzLm5ldHNjYXBlLmNvbS9vY3NwMA0GCSqGSIb3DQEBBQUAA4GBAFo11Z0i3LS3v79ERUII
kQw/Of200mw1k4qgUe5+ZCHJCT/NMUGpsVufSQhLHsAxgUtOsQU7Llcgkv2HxSJ0YcI339p1
fEh6cWL4g8UL/tq6Xgxa9JBDwZ0TXcaOR1Ue+boWazl1O9wAGVZLZbmhpAtK/rR0Xtubw5lL
eLeJOK5jMIID+TCCA2KgAwIBAgICbfswDQYJKoZIhvcNAQEEBQAwgZMxCzAJBgNVBAYTAlVT
MQswCQYDVQQIEwJDQTEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEbMBkGA1UEChMSQW1lcmlj
YSBPbmxpbmUgSW5jMRkwFwYDVQQLExBBT0wgVGVjaG5vbG9naWVzMScwJQYDVQQDEx5JbnRy
YW5ldCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwHhcNMDMwNjAzMDA1NjI3WhcNMDMxMTMwMDA1
NjI3WjB9MQswCQYDVQQGEwJVUzEbMBkGA1UEChMSQW1lcmljYSBPbmxpbmUgSW5jMRcwFQYK
CZImiZPyLGQBARMHamdteWVyczEjMCEGCSqGSIb3DQEJARYUamdteWVyc0BuZXRzY2FwZS5j
b20xEzARBgNVBAMTCkpvaG4gTXllcnMwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMcZ
B138GfG/ZBtJtdSEKALNz7NxibeihURffNrSGi53bXO/jcmBqkdHTCd3tpwmdXGWYkymXO56
t15Mj1eaq85VcATNhl7O9n8DDjktYgsh8yXptYLfED5BEWtrlaBOPgGpBG11X9YafUMRy2Ki
mwKcaDvqY7ZTxiA64u9GkuqRAgMBAAGjggFvMIIBazAPBgNVHQ8BAf8EBQMDB4AAMB0GA1Ud
JQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDBDBglghkgBhvhCAQ0ENhY0SXNzdWVkIGJ5IE5l
dHNjYXBlIENlcnRpZmljYXRlIE1hbmFnZW1lbnQgU3lzdGVtIDQuNTCBjwYDVR0RBIGHMIGE
gRRqZ215ZXJzQG5ldHNjYXBlLmNvbYEQamdteWVyc0BtY29tLmNvbYETam9obl9teWVyc0Bt
Y29tLmNvbYEXam9obl9teWVyc0BuZXRzY2FwZS5jb22BF2pvaG5nbXllcnNAbmV0c2NhcGUu
Y29tgRNqb2huZ215ZXJzQG1jb20uY29tMB8GA1UdIwQYMBaAFCnbsi2Dfn+LI7vCzGa5Oegp
8wKGMEEGCCsGAQUFBwEBBDUwMzAxBggrBgEFBQcwAYYlaHR0cDovL2NlcnRpZmljYXRlcy5u
ZXRzY2FwZS5jb20vb2NzcDANBgkqhkiG9w0BAQQFAAOBgQDLhP1VKAUm7V4tbVY4eI/QY1O0
LahSTyvFj4sF+pAHcRi9rXVnOYCvGKDS3cRxkraJnwKbrtUeCTlkt207yaqHkXNPGMEXK5a/
Zq/woS11zjrri3vDkykfF/VfSKsaa0E6GJ0lrC6/IdZsdXCHd3SmuuC3X+Gq2uVRytDh5bl/
UTGCA1QwggNQAgEBMIGaMIGTMQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFjAUBgNVBAcT
DU1vdW50YWluIFZpZXcxGzAZBgNVBAoTEkFtZXJpY2EgT25saW5lIEluYzEZMBcGA1UECxMQ
QU9MIFRlY2hub2xvZ2llczEnMCUGA1UEAxMeSW50cmFuZXQgQ2VydGlmaWNhdGUgQXV0aG9y
aXR5AgJt+zAJBgUrDgMCGgUAoIICDzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wMzA2MTkyMDU0MjVaMCMGCSqGSIb3DQEJBDEWBBQTAWtWe6IQHIcVd3qI
sOshvbMf0jBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAN
BggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBqwYJKwYBBAGCNxAEMYGd
MIGaMIGTMQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFjAUBgNVBAcTDU1vdW50YWluIFZp
ZXcxGzAZBgNVBAoTEkFtZXJpY2EgT25saW5lIEluYzEZMBcGA1UECxMQQU9MIFRlY2hub2xv
Z2llczEnMCUGA1UEAxMeSW50cmFuZXQgQ2VydGlmaWNhdGUgQXV0aG9yaXR5AgJt+jCBrQYL
KoZIhvcNAQkQAgsxgZ2ggZowgZMxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEWMBQGA1UE
BxMNTW91bnRhaW4gVmlldzEbMBkGA1UEChMSQW1lcmljYSBPbmxpbmUgSW5jMRkwFwYDVQQL
ExBBT0wgVGVjaG5vbG9naWVzMScwJQYDVQQDEx5JbnRyYW5ldCBDZXJ0aWZpY2F0ZSBBdXRo
b3JpdHkCAm36MA0GCSqGSIb3DQEBAQUABIGAQcP62nEFbh4VtQ14quZZqDBnHnKNX1WJL7/j
f08L0q2bDPjMJ+Kkp9vpzNc8fdJ4tdSts/2zxNi768TF+hB7wK3zP07Lnss9GQQUrDwXbuwQ
wpWI1kPN03RcX3eFW+f2s/KpOvOk9Wv81vG1FJlcigippEFnat13a+G6vQT/g44AAAAAAAA=
--------------ms080404040305040902080504--

