Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSJOVoT>; Tue, 15 Oct 2002 17:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264935AbSJOVoT>; Tue, 15 Oct 2002 17:44:19 -0400
Received: from c3po.netscape.com ([205.217.237.46]:20670 "EHLO netscape.com")
	by vger.kernel.org with ESMTP id <S264931AbSJOVoQ>;
	Tue, 15 Oct 2002 17:44:16 -0400
Message-ID: <3DAC8D8C.8060000@netscape.com>
Date: Tue, 15 Oct 2002 14:50:04 -0700
From: jgmyers@netscape.com (John Myers)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <3DAB46FD.9010405@watson.ibm.com> <20021015110501.B11395@redhat.com> <3DAC4B0E.EBB3A2AB@kegel.com> <3DAC59ED.2070405@watson.ibm.com> <3DAC643C.86A016B4@kegel.com> <20021015145731.J14596@redhat.com> <3DAC79D3.2010908@netscape.com> <3DAC840E.A601C318@kegel.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080700080805000709030504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080700080805000709030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dan Kegel wrote:

>The most effective way to use something like /dev/epoll in a
>multithreaded 
>program might be to have one thread call "get next batch of events",
>then divvy up the events across multiple threads.  
>
That is a tautology.  As /dev/epoll is inherently a single threaded 
interface, of course the most effective way for a multithreaded program 
to use it is to have one thread call it then divvy up the events. 
 That's the *only* way a multithreaded program can deal with a single 
threaded interface.

The cost to divvy up the events can be substantial, not the mention the 
cost of funneling them all through a single CPU.  This cost can easily 
be greater than what one saves by combining events.  io_getevents() is a 
great model for divvying events across multiple threads, the poll 
facility should work with that model.

The solution for optimizing the amount of event collapsing is to 
implement concurrency control.

>Once you allow that, it's easy to handle the
>condition you're worried about by generating a spurious readiness
>indication when registering a fd.  That's what I do in my wrapper
>library.
>
This is a workaround.  You are adding additional code and complexity to 
the caller in order to deal with a deficiency in the interface.  This 
has several problems:

Someone writing to the /dev/epoll interface needs to know that they need 
to write such workaround code.  If they don't know to write the code or 
if they make an error in the workaround code, it is still likely that 
the program will pass testing.  What will result are intermittent, hard 
to diagnose failures in production.

User space does not have the information to address this as well as the 
kernel can.  As a result, the workaround requires more processing in the 
common, non racy case.

The kernel can clearly handle this situation better than user space.  It 
can do the necessary checks while it is still holding the necessary 
locks.  It is less error prone to handle the situation in the kernel. 
 The logic clearly belongs in the kernel.

>Also, because /dev/epoll and friends are single-shot notifications of
>*changes* in readiness, there is little reason to register interest in
>this or that event, and change that interest over time; instead,
>apps should simply register interest in any event they might ever
>be interested in.
>
You're making assumptions about the structure and flow of an 
application.  Sometimes when an application stops having interest in 
this or that event, it needs to free/invalidate the context associated 
with that event.

So that's fine as a strategy for amortizing the cost of 
registration/deregistration, but it isn't universally applicable.


--------------ms080700080805000709030504
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIK7TCC
A4UwggLuoAMCAQICAlvfMA0GCSqGSIb3DQEBBAUAMIGTMQswCQYDVQQGEwJVUzELMAkGA1UE
CBMCQ0ExFjAUBgNVBAcTDU1vdW50YWluIFZpZXcxGzAZBgNVBAoTEkFtZXJpY2EgT25saW5l
IEluYzEZMBcGA1UECxMQQU9MIFRlY2hub2xvZ2llczEnMCUGA1UEAxMeSW50cmFuZXQgQ2Vy
dGlmaWNhdGUgQXV0aG9yaXR5MB4XDTAyMDYwMTIwMjIyM1oXDTAyMTEyODIwMjIyM1owfTEL
MAkGA1UEBhMCVVMxGzAZBgNVBAoTEkFtZXJpY2EgT25saW5lIEluYzEXMBUGCgmSJomT8ixk
AQETB2pnbXllcnMxIzAhBgkqhkiG9w0BCQEWFGpnbXllcnNAbmV0c2NhcGUuY29tMRMwEQYD
VQQDEwpKb2huIE15ZXJzMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDsB5tbTLWFycke
FKQwy1MTNx7SFtehB26RBx2gT+6+5/sYfXuLmBOuEOU2646fK0tz4rFOXfR8TcLfxOp3anh2
3pKDAnBEOp5u75bEIwY5nteR0opdni/CTeyCfJ1uPuYdNKTYC088GwbpzhBRE8n1APHXCBgv
bnGAuuYw/BqDtwIDAQABo4H8MIH5MA4GA1UdDwEB/wQEAwIFIDAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwQwYJYIZIAYb4QgENBDYWNElzc3VlZCBieSBOZXRzY2FwZSBDZXJ0
aWZpY2F0ZSBNYW5hZ2VtZW50IFN5c3RlbSA0LjUwHwYDVR0RBBgwFoEUamdteWVyc0BuZXRz
Y2FwZS5jb20wHwYDVR0jBBgwFoAUKduyLYN+f4sju8LMZrk56CnzAoYwQQYIKwYBBQUHAQEE
NTAzMDEGCCsGAQUFBzABhiVodHRwOi8vY2VydGlmaWNhdGVzLm5ldHNjYXBlLmNvbS9vY3Nw
MA0GCSqGSIb3DQEBBAUAA4GBAHhQSSAs8Vmute2hyZulGeFAZewLIz+cDGBOikFTP0/mIPmC
leog5JnWRqXOcVvQhqGg91d9imNdN6ONBE9dNkVDZPiVcgJ+J3wc+htIAc1duKc1CD3K6CM1
ouBbe4h4dhLWvyLWIcPPXNiGIBhA0PqoZlumSN3wlWdRqMaTC4P0MIIDhjCCAu+gAwIBAgIC
W+AwDQYJKoZIhvcNAQEEBQAwgZMxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEWMBQGA1UE
BxMNTW91bnRhaW4gVmlldzEbMBkGA1UEChMSQW1lcmljYSBPbmxpbmUgSW5jMRkwFwYDVQQL
ExBBT0wgVGVjaG5vbG9naWVzMScwJQYDVQQDEx5JbnRyYW5ldCBDZXJ0aWZpY2F0ZSBBdXRo
b3JpdHkwHhcNMDIwNjAxMjAyMjIzWhcNMDIxMTI4MjAyMjIzWjB9MQswCQYDVQQGEwJVUzEb
MBkGA1UEChMSQW1lcmljYSBPbmxpbmUgSW5jMRcwFQYKCZImiZPyLGQBARMHamdteWVyczEj
MCEGCSqGSIb3DQEJARYUamdteWVyc0BuZXRzY2FwZS5jb20xEzARBgNVBAMTCkpvaG4gTXll
cnMwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMkrxhwWBuZImCjNet4bJ6Vdv/iXgHQs
oXf8wdBaJZ2X6jJ17ZzlSha9mmwt3Z9H8LFfVdS+dz29ri1fBuvf0rcxPWdZkKi6HDag2yNV
f3CV+650RlyzuQr2RNeirkKvaocmakRdplHRw81Txxoi5sCMrkVPmRWA35ILnNbn6sTvAgMB
AAGjgf0wgfowDwYDVR0PAQH/BAUDAweAADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUH
AwQwQwYJYIZIAYb4QgENBDYWNElzc3VlZCBieSBOZXRzY2FwZSBDZXJ0aWZpY2F0ZSBNYW5h
Z2VtZW50IFN5c3RlbSA0LjUwHwYDVR0RBBgwFoEUamdteWVyc0BuZXRzY2FwZS5jb20wHwYD
VR0jBBgwFoAUKduyLYN+f4sju8LMZrk56CnzAoYwQQYIKwYBBQUHAQEENTAzMDEGCCsGAQUF
BzABhiVodHRwOi8vY2VydGlmaWNhdGVzLm5ldHNjYXBlLmNvbS9vY3NwMA0GCSqGSIb3DQEB
BAUAA4GBAExH0StQaZ/phZAq9PXm8btBCaH3FQsH+P58+LZF/DYQRw/XL+a3ieI6O+YIgMrC
sQ+vtlCGqTdwvcKhjjgzMS/ialrV0e2COhxzVmccrhjYBvdF8Gzi/bcDxUKoXpSLQUMnMdc3
2Dtmo+t8EJmuK4U9qCWEFLbt7L1cLnQvFiM4MIID1jCCAz+gAwIBAgIEAgAB5jANBgkqhkiG
9w0BAQUFADBFMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPR1RFIENvcnBvcmF0aW9uMRwwGgYD
VQQDExNHVEUgQ3liZXJUcnVzdCBSb290MB4XDTAxMDYwMTEyNDcwMFoXDTA0MDYwMTIzNTkw
MFowgZMxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEWMBQGA1UEBxMNTW91bnRhaW4gVmll
dzEbMBkGA1UEChMSQW1lcmljYSBPbmxpbmUgSW5jMRkwFwYDVQQLExBBT0wgVGVjaG5vbG9n
aWVzMScwJQYDVQQDEx5JbnRyYW5ldCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwgZ8wDQYJKoZI
hvcNAQEBBQADgY0AMIGJAoGBAOLvXyx2Q4lLGl+z5fiqb4svgU1n/71KD2MuxNyF9p4sSSYg
/wAX5IiIad79g1fgoxEZEarW3Lzvs9IVLlTGbny/2bnDRtMJBYTlU1xI7YSFmg47PRYHXPCz
eauaEKW8waTReEwG5WRB/AUlYybr7wzHblShjM5UV7YfktqyEkuNAgMBAAGjggGCMIIBfjBN
BgNVHR8ERjBEMEKgQKA+hjxodHRwOi8vd3d3MS51cy1ob3N0aW5nLmJhbHRpbW9yZS5jb20v
Y2dpLWJpbi9DUkwvR1RFUm9vdC5jZ2kwHQYDVR0OBBYEFCnbsi2Dfn+LI7vCzGa5Oegp8wKG
MGYGA1UdIARfMF0wRgYKKoZIhvhjAQIBBTA4MDYGCCsGAQUFBwIBFipodHRwOi8vd3d3LmJh
bHRpbW9yZS5jb20vQ1BTL09tbmlSb290Lmh0bWwwEwYDKgMEMAwwCgYIKwYBBQUHAgEwWAYD
VR0jBFEwT6FJpEcwRTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD0dURSBDb3Jwb3JhdGlvbjEc
MBoGA1UEAxMTR1RFIEN5YmVyVHJ1c3QgUm9vdIICAaMwKwYDVR0QBCQwIoAPMjAwMTA2MDEx
MjQ3MzBagQ8yMDAzMDkwMTIzNTkwMFowDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwQIMAYBAf8C
AQEwDQYJKoZIhvcNAQEFBQADgYEASmIO2fpGdwQKbA3d/tIiOZkQCq6ILYY9V4TmEiQ3aftZ
XuIRsPmfpFeGimkfBmPRfe4zNkkQIA8flxcsJ2w9bDkEe+JF6IcbVLZgQW0drgXznfk6NJrj
e2tMcfjrqCuDsDWQTBloce3wYyJewlvsIHq1sFFz6QfugWd2eVP3ldQxggKmMIICogIBATCB
mjCBkzELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3
MRswGQYDVQQKExJBbWVyaWNhIE9ubGluZSBJbmMxGTAXBgNVBAsTEEFPTCBUZWNobm9sb2dp
ZXMxJzAlBgNVBAMTHkludHJhbmV0IENlcnRpZmljYXRlIEF1dGhvcml0eQICW+AwCQYFKw4D
AhoFAKCCAWEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDIx
MDE1MjE1MDA0WjAjBgkqhkiG9w0BCQQxFgQUgxQx5juzHhQzyKNxTgm8v9Osj8owUgYJKoZI
hvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgwga0GCyqGSIb3DQEJEAILMYGdoIGaMIGTMQswCQYD
VQQGEwJVUzELMAkGA1UECBMCQ0ExFjAUBgNVBAcTDU1vdW50YWluIFZpZXcxGzAZBgNVBAoT
EkFtZXJpY2EgT25saW5lIEluYzEZMBcGA1UECxMQQU9MIFRlY2hub2xvZ2llczEnMCUGA1UE
AxMeSW50cmFuZXQgQ2VydGlmaWNhdGUgQXV0aG9yaXR5AgJb3zANBgkqhkiG9w0BAQEFAASB
gC0Jb7/OpeWYLcdMJqRdLZjGVh6g3Z9FzxIFGxMsHVfwl9/+F0H4WqxmCJld4ohvkASh9pTf
HyjobuKijyJHPxWf4IWGCo53D9Gr/KhLzouJ76vhcMfq9EgiI7gpI8lbQqJqWdO44p2eqJG5
ULmDDKUH/EdSkHxj3NAoCDix4JE9AAAAAAAA
--------------ms080700080805000709030504--

