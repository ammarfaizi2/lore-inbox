Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130390AbQJ1ArD>; Fri, 27 Oct 2000 20:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130404AbQJ1Aqw>; Fri, 27 Oct 2000 20:46:52 -0400
Received: from h-205-217-237-46.netscape.com ([205.217.237.46]:1202 "EHLO
	netscape.com") by vger.kernel.org with ESMTP id <S130390AbQJ1Aqg>;
	Fri, 27 Oct 2000 20:46:36 -0400
Date: Fri, 27 Oct 2000 17:46:25 -0700
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: Linux's implementation of poll() not scalable?
To: linux-kernel@vger.kernel.org
Message-id: <39FA21E1.A9229CAE@netscape.com>
MIME-version: 1.0
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
Content-type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha1; boundary=------------msC336CB11891ACB1FC18A9DCA
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------msC336CB11891ACB1FC18A9DCA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvolds wrote:
> So sticky arrays of events are good, while queues are bad. Let's take that 
> as one of the fundamentals.

Please let's not.  There is nothing fundamentally different between an
event queue of size N and an interest set of size N.

Your proposed interface suffers from most of the same problems as the
other Unix event interfaces I've seen.  Key among the problems are
inherent race conditions when the interface is used by multithreaded
applications.

The "stickiness" of the event binding can cause race conditions where
two threads simultaneously attempt to handle the same event.  For
example, consider a socket becomes writeable, delivering a writable
event to one of the multiple threads calling get_events().  While the
callback for that event is running, it writes to the socket, causing the
socket to become non-writable and then writeable again.  That in turn
can cause another writable event to be delivered to some other thread.

In the async I/O library I work with, this problem is addressed by
having delivery of the event atomically remove the binding.  If the
event needs to be bound after the callback is finished, then it is the
responsibility for the callback to rebind the event.  Typically, a
server implements a command/response protocol, where the read callback 
reads a command, writes the response, and repeats.  It is quite likely
that after the read callback completes, the connection is interested in
a write event, not another read event.

Cancellation of event bindings is another area prone to race
conditions.  A thread canceling an event binding frequently needs to
know whether or not that event has been delivered to some other thread. 
If it has, the canceling thread has to synchronize with the other thread
before destroying any resources associated with the event.

Multiple event queues are needed by libraries as different libraries can
have different thread pools.  The threads in those different pools can
have different characteristics, such as stack size, priority, CPU
affinity, signal state, etc.

There are three performance issues that need to be addressed by the
implementation of get_events().  One is that events preferably be given
to threads that are the same CPU as bound the event.  That allows the
event's context to remain in the CPU's cache.

Two is that of threads on a given CPU, events should wake threads in
LIFO order.  This allows excess worker threads to be paged out.

Three is that the event queue should limit the number of worker threads
contending with each other for CPU.  If an event is triggered while
there are enough worker threads in runnable state, it is better to wait
for one of those threads to block before delivering the event.
--------------msC336CB11891ACB1FC18A9DCA
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIIXwYJKoZIhvcNAQcCoIIIUDCCCEwCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
BlkwggMMMIICdaADAgECAgIeFDANBgkqhkiG9w0BAQQFADCBkzELMAkGA1UEBhMCVVMxCzAJ
BgNVBAgTAkNBMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3MRswGQYDVQQKExJBbWVyaWNhIE9u
bGluZSBJbmMxGTAXBgNVBAsTEEFPTCBUZWNobm9sb2dpZXMxJzAlBgNVBAMTHkludHJhbmV0
IENlcnRpZmljYXRlIEF1dGhvcml0eTAeFw0wMDA2MDIxNzE1MjlaFw0wMDExMjkxNzE1Mjla
MIGCMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbmV0c2NhcGUxIzAh
BgkqhkiG9w0BCQEWFGpnbXllcnNAbmV0c2NhcGUuY29tMRMwEQYDVQQDEwpKb2huIE15ZXJz
MRcwFQYKCZImiZPyLGQBARMHamdteWVyczCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA
0+WYWlf3g+u6vFEBJwo+4Cxz0PM5GUuqOHGVkjPFTeGjR05BUJADWm8mZDoAhUuIVuTvixCx
AB0f5JzDWmIIWbB0ea92RwOHdibSS3bT0BTwKNTgt+PQAH3ZdH+IjmGAZI6/J+5Ob3m43ZZl
o/3lfGEd4O7gAJY62Sy76MgO1O0CAwEAAaN+MHwwEQYJYIZIAYb4QgEBBAQDAgWgMA4GA1Ud
DwEB/wQEAwIEsDAfBgNVHSMEGDAWgBSiO2Uy9/cbifxVDQcBvIdIWv2QPTA2BggrBgEFBQcB
AQQqMCgwJgYIKwYBBQUHMAGGGmh0dHA6Ly9uc29jc3AubmV0c2NhcGUuY29tMA0GCSqGSIb3
DQEBBAUAA4GBAGPAOC3FZineuE0PLv+pKc52i5uz+lpHzvssmUrr5FNSSD3M+DBow7Sd3YW+
vyPVAxH+MZ5RtE+If/aDDYQhgpCtbujQb5wPVRS5ZCmKpAC0eOnP12jcUDLr1tfhyBIlIvJQ
6xGKj7ckSK6G7lNxuQ8a12v/v2yEEk2uADg51oY7MIIDRTCCAq6gAwIBAgIBJzANBgkqhkiG
9w0BAQQFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UE
BxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2Vy
dGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUu
Y29tMB4XDTk5MDYwMzIyMDAzNFoXDTAxMDYwMjIyMDAzNFowgZMxCzAJBgNVBAYTAlVTMQsw
CQYDVQQIEwJDQTEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEbMBkGA1UEChMSQW1lcmljYSBP
bmxpbmUgSW5jMRkwFwYDVQQLExBBT0wgVGVjaG5vbG9naWVzMScwJQYDVQQDEx5JbnRyYW5l
dCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAOLv
Xyx2Q4lLGl+z5fiqb4svgU1n/71KD2MuxNyF9p4sSSYg/wAX5IiIad79g1fgoxEZEarW3Lzv
s9IVLlTGbny/2bnDRtMJBYTlU1xI7YSFmg47PRYHXPCzeauaEKW8waTReEwG5WRB/AUlYybr
7wzHblShjM5UV7YfktqyEkuNAgMBAAGjaTBnMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0l
BBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMBEGCWCGSAGG+EIBAQQEAwIBAjAfBgNVHSMEGDAW
gBRyScJzNMZV9At2coF+d/SH58ayDjANBgkqhkiG9w0BAQQFAAOBgQC6UH38ALL/QbQHCDkM
IfRZSRcIzI7TzwxW8W/oCxppYusGgltprB2EJwY5yQ5+NRPQfsCPnFh8AzEshxDVYjtw1Q6x
ZIA0Tln6xlnmRt5OaAh1QPUdjCnWrnetyT1p5ECNRJdGb756wFiksR9qpw8pUYqBDSmOneQP
MwuPjSQ97DGCAc4wggHKAgEBMIGaMIGTMQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFjAU
BgNVBAcTDU1vdW50YWluIFZpZXcxGzAZBgNVBAoTEkFtZXJpY2EgT25saW5lIEluYzEZMBcG
A1UECxMQQU9MIFRlY2hub2xvZ2llczEnMCUGA1UEAxMeSW50cmFuZXQgQ2VydGlmaWNhdGUg
QXV0aG9yaXR5AgIeFDAJBgUrDgMCGgUAoIGKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTAwMTAyODAwNDYyNVowIwYJKoZIhvcNAQkEMRYEFCPoNfxqzn9N
cXF4jGf4DUYVAYOEMCsGCSqGSIb3DQEJDzEeMBwwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwIC
AgCAMA0GCSqGSIb3DQEBAQUABIGAH8vp50vaF0GB/qrFuG71AYge5UhmD1tZftINBKLhrXX4
ZA/YsDr3f6+t/KOAIQx5i3oIcmv9b4RWa9EgnIBZM8sm79/VWw2Lh8XnksLH+m2hgj061Zny
kDWfuGHmJ7jCLP9uAmHm8GsX5QiVEl44ZFFiMfwIpUOLLRocFDCJU2Q=
--------------msC336CB11891ACB1FC18A9DCA--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
