Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265166AbSJOXVO>; Tue, 15 Oct 2002 19:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264921AbSJOXVO>; Tue, 15 Oct 2002 19:21:14 -0400
Received: from mtao-m02.ehs.aol.com ([64.12.52.8]:46033 "EHLO
	mtao-m02.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S265166AbSJOXVL>; Tue, 15 Oct 2002 19:21:11 -0400
Date: Tue, 15 Oct 2002 16:26:59 -0700
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: [PATCH] async poll for 2.5
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Message-id: <3DACA443.7030103@netscape.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------ms040306030002020302010406; micalg=sha1;
 protocol="application/x-pkcs7-signature"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2a)
 Gecko/20020910
References: <Pine.LNX.4.44.0210151521090.1554-100000@blue1.dev.mcafeelabs.com>
 <3DAC9859.5060005@netscape.com> <20021015184123.J16156@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms040306030002020302010406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin LaHaise wrote:

>I suppose one way of getting the async poll code up to snuff would be to 
>cache the poll registration in the file descriptor.  Alternatively, the 
>iocb could simply persist until it is cancelled or a refire is permitted 
>(so that the event queue does not get overrun).
>
First, can you confirm that your only problem with the async poll code 
is the fact that it doesn't amortize the registration/deregistration 
cost across multiple events?

I would say that the fact that the async poll code doesn't do this 
amortization is not sufficient reason to hold up the patch.  A 
non-amortizing async poll is sufficiently useful to warrant inclusion. 
 It is conceivable that some applications will not want to amortize some 
of their poll requests.  The non-amortizing interface can later be 
extended to an amortizing one by defining an "amortize me" bit to the 
events request mask.

I don't think caching the registration in the file descriptor is a good 
idea--there can be multiple registrations against a given fd.  The 
registration should be cached close to the iocb--either in the iocb or 
in some structure that directly references the iocb.

The model for multiple-events-per-iocb I was thinking of is as follows:

Add a concept of a "partial completion".  Unlike a normal completion, 
when a partial completion event fires the iocb is not freed.  Instead 
the iocb goes into a "fired" state.

When an iocb is in the fired state, it will not generate any more 
completion events until it is "rearmed" by user space.  The method by 
which user space rearms an iocb is to be determined.  Upon rearming, the 
iocb is once again able to generate either a partial or normal 
completion.  As with submission, rearming can generate this completion 
immediately if the situation warrants.

Canceling an iocb in the rearmed state is the same as canceling an iocb 
that has never generated a completion event.  Canceling an iocb in the 
fired state returns a normal completion through the cancellation 
interface and returns a distinct error code (not 0 or -EAGAIN) to inform 
the caller that there is an outstanding event to be synchronized with.

Attempting to rearm a canceled iocb returns an error, probably -EAGAIN 
to be consistent with cancellation.



--------------ms040306030002020302010406
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
MDE1MjMyNjU5WjAjBgkqhkiG9w0BCQQxFgQU10a+l6ikECpA7Sjq7tC4e6rEMPEwUgYJKoZI
hvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgwga0GCyqGSIb3DQEJEAILMYGdoIGaMIGTMQswCQYD
VQQGEwJVUzELMAkGA1UECBMCQ0ExFjAUBgNVBAcTDU1vdW50YWluIFZpZXcxGzAZBgNVBAoT
EkFtZXJpY2EgT25saW5lIEluYzEZMBcGA1UECxMQQU9MIFRlY2hub2xvZ2llczEnMCUGA1UE
AxMeSW50cmFuZXQgQ2VydGlmaWNhdGUgQXV0aG9yaXR5AgJb3zANBgkqhkiG9w0BAQEFAASB
gB2p/A5wBeasOohNyBQEhkRzOPec39EcpfrcM9CBQ7JZK041IIcFbAsdssbWqOZmDz00vSkt
bH+n01q2GpFam8XG0mEF0fdd90lLA09CixuAo45pYWgclb6tFmcEerrt0HNf9RPqknjR2qvt
8zZJ/4X03ppQFeU7Qy2pLhvYv9NVAAAAAAAA
--------------ms040306030002020302010406--

